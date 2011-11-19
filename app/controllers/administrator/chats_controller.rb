# -*- encoding : utf-8 -*-
class Administrator::ChatsController < Administrator::AdminController

  before_filter :chat_menu_detalhes
  
  # GET /chats
  # GET /chats.xml
  def index
    
    if !params[:finalizado].nil? and params[:finalizado].to_i == 1
      redirect_to '/administrator', :notice => 'O cliente finalizou esse atendimento.'
      return nil
    end
    
    conditions = []
    conditions << "status = #{params[:status]}" unless params[:status].nil?
    conditions << "departamento_id = #{current_administrator_administrador.chat_departamento.id}" unless current_administrator_administrador.chat_departamento.nil?
    @chats = Chat.paginate :page => params[:page], :conditions => conditions.join(' AND ')

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
  
  # NAO MEXA NA NOTIFICACAO POR DEPARTAMENTO
  # VAI PARAR DE FUNCIONAR - TE GARANTO
  def novas_notificacoes
    
    @usuario = ChatAtendente.find(current_administrator_administrador.id)
    @chat_encaminhado = Chat.find( Chat.maximum('id') )
    @last_chat = params[:last_chat] || 0
    
    # chat esperando maior que último notificado
    deve_notificar1 = (@chat_encaminhado.esperando? and @chat_encaminhado.id > @last_chat.to_i and @last_chat.to_i != 0)
     
    # usuario trabalha em qualquer departamento ou
    # chat independe de departamento ou
    # chat é do departamento desse usuário
    deve_notificar2 = (@usuario.chat_departamento.nil? or @chat_encaminhado.chat_departamento.nil? or (@usuario.chat_departamento.id == @chat_encaminhado.chat_departamento.id))
    deve_notificar = (deve_notificar1 and deve_notificar2) # ATENCAO: NAO MEXA NISSO!!!!
    
    atualiza = deve_notificar ? 1 : 0
    
    # ! 5H DEBUGANDO, TOME CUIDADO !
    # logger.info '----------------11111111111---------------'
    # logger.info "Departamento Chat encaminhado: #{@chat_encaminhado.chat_departamento.id}"
    # logger.info "Departamento Usuario: #{@usuario.chat_departamento.id}"
    # logger.info ''
#     
    # logger.info "**** Deve notificar? #{deve_notificar} ****"
    # logger.info "** Atualiza? #{atualiza} **"
    # logger.info ''
#     
    # logger.info "Chat esperando? #{@chat_encaminhado.esperando?}"
    # logger.info "Chat não foi notificado? #{@chat_encaminhado.id > @last_chat.to_i}"
    # logger.info "Notificar1: #{deve_notificar1}"
    # logger.info "Usuário tem departamento nulo: #{@usuario.chat_departamento.nil?}"
    # logger.info "Chat tem departamento nulo: #{@chat_encaminhado.chat_departamento.nil?}"
    # logger.info "Departamento Usuário = Departamento Chat: #{@usuario.chat_departamento.id == @chat_encaminhado.chat_departamento.id}"
    # logger.info "Notificar2: #{deve_notificar2}"
    # logger.info "Notificar1 and Notificar2: #{deve_notificar1 and deve_notificar2}"
    # logger.info "(Notificar1 and Notificar2): #{(deve_notificar1 and deve_notificar2)}"
#     
    # logger.info ''
    # logger.info "Chat encaminhado: #{@chat_encaminhado.id}"
    # logger.info "Ultimo chat notificado: #{@last_chat}"
    # logger.info "Firefox" if browser.firefox?
    # logger.info "Chrome" unless browser.firefox?
    
    respond_to do |format|
      format.html { render :json => {:atualiza => atualiza.to_s, :chat_id => @chat_encaminhado.id.to_s } }
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
