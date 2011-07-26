# -*- encoding : utf-8 -*-
class ChatMensagensController < FrontendController

  def atualiza_mensagens
    # verifica se o chat foi finalizado
    @chat = Chat.find params[:chat_id]
    if @chat.finalizado?
      @resposta = {"finalizado" => 1, "cliente" => 1}
    else
      @resposta = ChatMensagem.where( "chat_id = #{params[:chat_id]} AND id > #{params[:last_id]}")
    end

    respond_to do |format|
      format.html {render :json => @resposta}
    end
  end


  # POST /mensagens
  # POST /mensagens.xml
  def create
    @mensagem = ChatMensagem.new(params[:mensagem])
    @mensagem.data = Time.now
    @mensagem.save
    
    respond_to do |format|
      format.html {render :nothing => true}
    end
  end

end
