# -*- encoding : utf-8 -*-
class ChatSession < ActiveRecord::Base
  
  validates :usuario_id, :dia, :entrada, :presence => true
  
  default_scope :order => "dia DESC, entrada DESC"
  
  def ChatSession.sessoes_abertas_hoje_pelo_usuario(usuario_id)
    return ChatSession.where(:dia => Date.today, :usuario_id => usuario_id)
  end
  
  
  def ChatSession.sessao_aberta(usuario_id)
    sessao = ChatSession.sessoes_abertas_hoje_pelo_usuario(usuario_id).first
    return (!sessao.nil? and sessao.saida.nil?)
  end
  
  def ChatSession.atendimento_online?(departamento = nil)
      sessoes_abertas = ChatSession.where(:dia => Date.today, :saida => nil)
      # não tem sessão aberta
      if sessoes_abertas.count.zero?
        return false
      end
      
      # tem sessão aberta, mas não importa o departamento
      if departamento.blank? and !sessoes_abertas.count.zero?
        return true
      end
      
      # verifica se os usuários logados, tem alguém disponível para o departamento
      tem_sessao_aberta_pro_departamento = false
      sessoes_abertas.each do |sessao|
        atendente = ChatAtendente.find(sessao.usuario_id)
        if atendente.chat_departamento.nil? or atendente.chat_departamento_id == departamento.id
          tem_sessao_aberta_pro_departamento = true
        end
      end
      
      return tem_sessao_aberta_pro_departamento
  end
  
end
