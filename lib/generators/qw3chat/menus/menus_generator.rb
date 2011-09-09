# -*- encoding : utf-8 -*-
module Qw3chat
  module Generators
    class MenusGenerator < Rails::Generators::Base
      
      source_root File.expand_path("../templates", __FILE__)
      
      def generate_menu_into_partial
        
        inject_into_class 'app/controllers/administrator/admin_controller.rb', Administrator::AdminController do
          "
          def chat_menu_detalhes
            @detalhes_parcial = 'chat'
          end
          
          def config_menu_detalhes
            @detalhes_parcial = 'chat_configuracao'
          end
          "  
        end
      end
      
    end
  end
end


  def chat_menu_detalhes
    @detalhes_partial = '/administrator/chats/menu_detalhes'
  end
  
  def config_menu_detalhes
    @detalhes_partial = '/administrator/configuracao_atendimento/menu_detalhes'
  end