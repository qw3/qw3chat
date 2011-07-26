# -*- encoding : utf-8 -*-
class Administrator::AdminController < ChatBaseController
  
  before_filter :backend
  before_filter :authenticate_administrator_administrador!
  
  def login
    ApplicationController.layout 'qw3chat/login'
  end
  
  def chat_layout
    ApplicationController.layout 'qw3chat/backend-chat' 
  end
  
  def chat_menu_detalhes
    @detalhes_partial = '/administrator/chats/menu_detalhes'
  end
  
  def config_menu_detalhes
    @detalhes_partial = '/administrator/configuracao_atendimento/menu_detalhes'
  end

end
