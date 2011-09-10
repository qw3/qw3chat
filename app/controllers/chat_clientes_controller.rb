# -*- encoding : utf-8 -*-
class ChatClientesController < ChatBaseController
  
  def new
    
    if params[:finalizado] == "1"
      redirect_to '/', :notice => 'Este atendimento foi finalizado pelo atendente.'
    end
    
    @cliente = ChatCliente.new
  end


  def create
    @cliente = ChatCliente.new(params[:chat_cliente])
    salvou = @cliente.save
    
    if ChatSession.atendimento_online? # online
      # inicia o chat
      @chat = Chat.new :chat_cliente => @cliente, :status => Chat::ESPERANDO, :inicio => Time.now, :departamento_id => params[:departamento_id]
      salvou = salvou and @chat.save
      if salvou
        session[:chat_id] = @chat.id
      end
      # salva a primeira mensagem
      @mensagem = ChatMensagem.new :autor => @cliente.nome, :texto => params[:mensagem], :chat_id => @chat.id, :data => Time.now
      @mensagem.texto = params[:mensagem].gsub(/\n/, ' ')
      salvou = salvou and @mensagem.save
    else #offline
      # envia email ao departamento responsável
      AtendimentoOffline.mensagem( ChatDepartamento.find_by_id(params[:departamento_id]), @cliente, params[:mensagem] ).deliver
    end

    respond_to do |format|
      if ChatSession.atendimento_online? and salvou
        format.html { redirect_to(@chat) }
      elsif !ChatSession.atendimento_online?
        format.html { redirect_to(new_chat_cliente_path, :notice => "Obrigado. Sua mensagem foi enviada. Em breve, entraremos em contato.") }
      else
        format.html { render :action => "new" }
      end
    end
  end

end
