# -*- encoding : utf-8 -*-
class Administrator::ChatAtendentesController < Administrator::AdminController
  
  before_filter :chat_menu_detalhes
  
  # GET /filiais
  # GET /filiais.xml
  def index
    conditions = []
    conditions << "nome LIKE '%#{params[:nome]}%'" unless params[:nome].blank?
    conditions << "email LIKE '%#{params[:email]}%'" unless params[:email].blank?
    
    @atendentes = ChatAtendente.paginate :page => params[:page], :conditions => conditions.join(' AND '), :order => 'nome ASC'

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @atendentes }
    end
  end

  # GET /filiais/new
  # GET /filiais/new.xml
  def new
    @atendente = ChatAtendente.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @atendente }
    end
  end

  # GET /filiais/1/edit
  def edit
    @atendente = ChatAtendente.find(params[:id])
  end

  # POST /filiais
  # POST /filiais.xml
  def create
    @atendente = ChatAtendente.new(params[:chat_atendente])

    respond_to do |format|
      if @atendente.save
        format.html { redirect_to(administrator_chat_atendentes_path, :notice => 'Atendente criado com sucesso.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /filiais/1
  # PUT /filiais/1.xml
  def update
    @atendente = ChatAtendente.find(params[:id])
    @atendente.nome = params[:chat_atendente][:nome]
    @atendente.email = params[:chat_atendente][:email]
    @atendente.chat_departamento_id = params[:chat_atendente][:chat_departamento_id]
    unless params[:chat_atendente][:password].blank?
      @atendente.password = params[:chat_atendente][:password]
      @atendente.password_confirmation = params[:chat_atendente][:password_confirmation] 
    end
    salvou = @atendente.save
    
    respond_to do |format|
      if salvou
        format.html { redirect_to(administrator_chat_atendentes_path, :notice => 'Atendente atualizado com sucesso.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /filiais/1
  # DELETE /filiais/1.xml
  def destroy
    @atendente = ChatAtendente.find(params[:id])
    @atendente.destroy

    respond_to do |format|
      format.html { redirect_to(administrator_chat_atendentes_path, :notice => "Atendente removido com sucesso!") }
      format.xml  { head :ok }
    end
  end
end
