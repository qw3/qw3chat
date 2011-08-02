# -*- encoding : utf-8 -*-
class Chat < ActiveRecord::Base
  
  belongs_to :chat_cliente, :foreign_key => :cliente_id
  belongs_to :usuario, :foreign_key => :atendente_id
  belongs_to :chat_departamento, :foreign_key => :departamento_id
  has_many :chat_mensagem
  
  validates :cliente_id, :presence => true
  
  default_scope :order => 'inicio DESC'
  
  cattr_reader :per_page
  @@per_page = 5
  
  ESPERANDO       = 0
  EM_ATENDIMENTO  = 1
  FINALIZADO      = 2 
  
  def status_to_s
    case self.status
    when ESPERANDO then return 'Esperando'
    when EM_ATENDIMENTO then return 'Em atendimento'
    when FINALIZADO then return 'Finalizado'
    else ''
    end
  end
  
  def esperando?
    return (self.status == ESPERANDO)
  end
  
  def em_atendimento?
    return (self.status == EM_ATENDIMENTO)
  end
  
  def finalizado?
    return (self.status == FINALIZADO)
  end
  
  def primeira_mensagem
    if self.mensagens.nil? or self.mensagens.count.zero?
      return ''
    end
    
    return self.mensagens.first.texto
  end
  
  def finalizar
    self.status = FINALIZADO
    # escreve o TXT que vai guardar as mensagens desse chat
    salvou = self.gravar_arquivo_chat
    # apaga as mensagens do BD
    self.mensagens.each do |m| 
      m.destroy
    end
    
    return (salvou and self.save)
  end
  
  
  def recuperar_historico
    chat_path = File.join("chats", "#{self.id}.txt")
    if !File.exists?(chat_path)
      self.finalizar
    end
    
    file = File.open(chat_path, "rb")
    historico = file.read
    return historico
  end
  
  
  def mensagens
    return self.chat_mensagem
  end

  def cliente
    return self.chat_cliente
  end  
  
  protected 
    def gravar_arquivo_chat
      mensagens = self.mensagens
      texto = ""
      mensagens.each do |mensagem|
        texto = texto + "(#{mensagem.data}) #{mensagem.autor}:::: #{mensagem.texto}\n"
      end
      caminho = "chats"
      FileUtils.mkdir_p(caminho)  if( !File.directory?(caminho) )
      return  File.open(File.join(caminho, "#{self.id}.txt"), 'w') {|f| f.write(texto) }
    end
end
