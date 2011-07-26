# -*- encoding : utf-8 -*-
class Administrator::ChatSessionsController < Administrator::AdminController

  # GET /chat_sessions
  # GET /chat_sessions.xml
  def index
    @chat_sessions = ChatSession.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chat_sessions }
    end
  end

  # GET /chat_sessions/1
  # GET /chat_sessions/1.xml
  def show
    @chat_session = ChatSession.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chat_session }
    end
  end

  # GET /chat_sessions/new
  # GET /chat_sessions/new.xml
  def new
    @chat_session = ChatSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chat_session }
    end
  end

  # GET /chat_sessions/1/edit
  def edit
    @chat_session = ChatSession.find(params[:id])
  end

  # POST /chat_sessions
  # POST /chat_sessions.xml
  def create
    @chat_session = ChatSession.new(params[:chat_session])

    respond_to do |format|
      if @chat_session.save
        format.html { redirect_to(@chat_session, :notice => 'Chat session was successfully created.') }
        format.xml  { render :xml => @chat_session, :status => :created, :location => @chat_session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chat_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chat_sessions/1
  # PUT /chat_sessions/1.xml
  def update
    @chat_session = ChatSession.find(params[:id])

    respond_to do |format|
      if @chat_session.update_attributes(params[:chat_session])
        format.html { redirect_to(@chat_session, :notice => 'Chat session was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chat_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chat_sessions/1
  # DELETE /chat_sessions/1.xml
  def destroy
    @chat_session = ChatSession.find(params[:id])
    @chat_session.destroy

    respond_to do |format|
      format.html { redirect_to(chat_sessions_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def iniciar
    @sessao = ChatSession.new
    @sessao.usuario_id = current_administrator_administrador
    @sessao.dia = Date.today
    @sessao.entrada = Time.now.strftime '%H:%M:%S'
    
    respond_to do |format|
      if( @sessao.save )
        format.html { redirect_to( administrator_chats_path, :notice => "Sucesso. Agora você pode atender clientes." ) }
      else
        format.html { redirect_to( administrator_chats_path, :notice => "Erro ao habilitar sessão de atendimento." ) }
      end
    end
  end
  
  def finalizar
    if !ChatSession.sessao_aberta current_administrator_administrador.id
      redirect_to( administrator_chat_sessions_path, :notice => "Sessão de atendimento ainda não iniciada." )
    end
    
    @ponto = ChatSession.sessoes_abertas_hoje_pelo_usuario(current_administrator_administrador.id).first
    @ponto.saida = Time.now.strftime '%H:%M:%S'
    
    respond_to do |format|
      if( @ponto.save )
        format.html { redirect_to( administrator_chats_path, :notice => "Sessão finalizada com sucesso." ) }
      else
        format.html { redirect_to( administrator_chats_path, :notice => "Erro ao finalizar sessão." ) }
      end
    end
  end
  
end
