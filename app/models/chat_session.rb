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
  
  def ChatSession.atendimento_online?
      return (ChatSession.where(:dia => Date.today, :saida => nil).count > 0)
  end
  
end
