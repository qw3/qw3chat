# -*- encoding : utf-8 -*-
class Administrator::ChatsController < Administrator::AdminController

  skip_before_filter :backend, :only => [:atender, :show]  
  before_filter :chat_layout, :only => [:atender, :show]
  before_filter :chat_menu_detalhes
  
  # GET /chats
  # GET /chats.xml
  def index
    
    if !params[:finalizado].nil? and params[:finalizado].to_i == 1
      redirect_to '/administrator', :notice => 'O cliente finalizou esse atendimento.'
      return nil
    end
    
    conditions = ["status = ?", params[:status]] unless params[:status].nil?
    @chats = Chat.paginate :page => params[:page], :conditions => conditions

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @chats }
    end
  end

  # GET /chats/1
  # GET /chats/1.xml
  def show
    @chat = Chat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chat }
    end
  end

  # GET /chats/new
  # GET /chats/new.xml
  def new
    @chat = Chat.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chat }
    end
  end

  # GET /chats/1/edit
  def edit
    @chat = Chat.find(params[:id])
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

  # PUT /chats/1
  # PUT /chats/1.xml
  def update
    @chat = Chat.find(params[:id])

    respond_to do |format|
      if @chat.update_attributes(params[:chat])
        format.html { redirect_to(@chat, :notice => 'Chat was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1
  # DELETE /chats/1.xml
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy

    respond_to do |format|
      format.html { redirect_to(chats_url) }
      format.xml  { head :ok }
    end
  end
  
  def atender
    
    # recupera as informações
    @chat = Chat.find_by_id params[:id]
    if @chat.nil? or @chat.finalizado?
      redirect_to '/administrator', :notice => 'Esse atendimento já foi finalizado ou excluído.'
      return nil
    end
    
    # atualiza o chat
    @chat.atendente_id  = current_administrator_administrador.id
    @chat.status        = Chat::EM_ATENDIMENTO
    pode_iniciar        = @chat.save
    
    respond_to do |format|
      if pode_iniciar
        format.html
      else
        format.html { redirect_to '/administrator', :notice => 'Ocorreu um problema ao atender esse chat.'}
      end
    end
    
  end
  
  def finalizar
    
    @chat = Chat.find params[:id]
    if @chat.nil? or @chat.finalizado?
      redirect_to '/administrator', :notice => 'Esse atendimento já foi finalizado ou excluído.'
      return nil
    end
    
    finalizou = @chat.finalizar
    respond_to do |format|
      if finalizou
        format.html { redirect_to '/administrator/chats', :notice => 'Atendimento finalizado com sucesso.' }
      else
        format.html { redirect_to '/administrator/chats', :notice => 'Ocorreu um problema ao finalizar esse atendimento.'}
      end
    end
    
  end
  
  def novas_notificacoes
    
    @last_chat = params[:last_chat] || 0
    atualiza = (!Chat.where(:status => Chat::ESPERANDO).count.zero? and Chat.maximum('id') > @last_chat.to_i and @last_chat.to_i != 0) ? 1 : 0
    
    respond_to do |format|
      format.html { render :json => {:atualiza => atualiza.to_s, :chat_id => Chat.maximum('id').to_s } }
    end
    
  end
  
  
  def visualizar
    
    @chat = Chat.find params[:id]
    if @chat.nil?
      redirect_to '/administrator', :notice => 'Esse atendimento não existe.'
      return nil
    end
    
    respond_to do |format|
      format.html
    end
    
  end
  
end
