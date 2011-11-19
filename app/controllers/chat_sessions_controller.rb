# -*- encoding : utf-8 -*-
class ChatSessionsController < ChatBaseController
  
  def verificar_status
    departamento = ChatDepartamento.find params[:departamento_id]
    @online = ChatSession.atendimento_online?( departamento )
    
    respond_to do |format|
      format.js
    end
  end
  
end
