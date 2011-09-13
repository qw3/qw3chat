# -*- encoding : utf-8 -*-
class ChatsController < ChatBaseController
  
  # GET /chats/1
  # GET /chats/1.xml
  def show
    @chat = Chat.find( params[:id] )
    if @chat.em_atendimento?
      redirect_to '/', :notice => 'Você não possui permissão de acesso a essa página.'
      return nil
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chat }
    end
  end


  # POST /chats
  # POST /chats.xml
  def create
    @chat = Chat.find_by_id(params[:chat_id])
    if @chat.nil?
      @chat = Chat.new
    end
    @chat.cliente = params[:cliente]
    @chat.atendente = nil
    @chat.save

    response = {:chat_id => @chat.id, :last_id => 0}

    respond_to do |format|
      format.html  { render :json => response }
    end
  end
  
  
  def fechar
    
    @chat = Chat.find params[:id]
    @chat.status = Chat::FINALIZADO
    @chat.save
    
    respond_to do |format|
      format.html { render :nothing => true }
    end
  end
  
end
