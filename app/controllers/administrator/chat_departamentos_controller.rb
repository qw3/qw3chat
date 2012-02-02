# -*- encoding : utf-8 -*-
class Administrator::ChatDepartamentosController < Administrator::AdminController
  
  before_filter :chat_menu_detalhes
  
  # GET /chat_departamentos
  # GET /chat_departamentos.xml
  def index
    @chat_departamentos = ChatDepartamento.paginate :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @chat_departamentos }
    end
  end

  # GET /chat_departamentos/1
  # GET /chat_departamentos/1.xml
  def show
    @chat_departamento = ChatDepartamento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chat_departamento }
    end
  end

  # GET /chat_departamentos/new
  # GET /chat_departamentos/new.xml
  def new
    @chat_departamento = ChatDepartamento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chat_departamento }
    end
  end

  # GET /chat_departamentos/1/edit
  def edit
    @chat_departamento = ChatDepartamento.find(params[:id])
  end

  # POST /chat_departamentos
  # POST /chat_departamentos.xml
  def create
    @chat_departamento = ChatDepartamento.new(params[:chat_departamento])

    respond_to do |format|
      if @chat_departamento.save
        format.html { redirect_to(administrator_chat_departamentos_path, :notice => 'Departamento salvo com sucesso.') }
        format.xml  { render :xml => @chat_departamento, :status => :created, :location => @chat_departamento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chat_departamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chat_departamentos/1
  # PUT /chat_departamentos/1.xml
  def update
    @chat_departamento = ChatDepartamento.find(params[:id])

    respond_to do |format|
      if @chat_departamento.update_attributes(params[:chat_departamento])
        format.html { redirect_to(administrator_chat_departamentos_path, :notice => 'Departamento salvo com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chat_departamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chat_departamentos/1
  # DELETE /chat_departamentos/1.xml
  def destroy
    @chat_departamento = ChatDepartamento.find(params[:id])
    @chat_departamento.destroy

    respond_to do |format|
      format.html { redirect_to(administrator_chat_departamentos_url, :notice => 'Departamento excluido com sucesso.') }
      format.xml  { head :ok }
    end
  end
end
