class ChatAtendente < Administrador
  
  belongs_to :chat_departamento
  attr_accessible :chat_departamento, :chat_departamento_id
  
  after_create :dar_permissao_de_atendente
  after_destroy :apagar_sessoes
  
  def dar_permissao_de_atendente
    # se existe permissionamento de usuário    
    if self.methods.include? :permissoes
      Permissao.create(:nome => 'Atendente') if Permissao.find_by_nome('Atendente').nil? # cria a permissão de atendente se não existe
      self.permissoes.push Permissao.find_by_nome('Atendente')
    end
  end
  
  def apagar_sessoes
    ChatSession.where(:usuario_id => self.id).each do |sessao|
      sessao.destroy
    end
  end
  
end