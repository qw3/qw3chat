# -*- encoding : utf-8 -*-
class AtendimentoOffline < ActionMailer::Base
  
  def mensagem(departamento, cliente, mensagem)
    @departamento   = departamento
    @cliente        = cliente
    @mensagem       = mensagem
    @assunto        = '[Atendimento online] - Cliente enviou uma mensagem enquanto atendimento estava offline'
    email_to = (!departamento.nil?) ? departamento.email : Settings["QW3CHAT.email_padrao"]
    
    mail(:to => email_to, :subject => @assunto, :from => 'contato@qw3.com.br') do |format|
      format.html
      format.text
    end
  end
  
end
