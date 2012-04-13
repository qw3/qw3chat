# -*- encoding : utf-8 -*-
require 'rails/generators'
require 'rails/generators/migration'
   
module Qw3chat
  module Generators
    class InstallGenerator < Rails::Generators::Base

      include Rails::Generators::Migration
    
      source_root File.expand_path("../templates", __FILE__)
      
      # Implement the required interface for Rails::Generators::Migration.
      # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S").to_s + rand(1230).to_s
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
    
      def create_migration_files
        
        if yes? 'Gerar migrations?'
          migration_template 'migrations/clientes.rb', 'db/migrate/create_chat_clientes.rb'
          sleep( 1.0 ) # Espera 1 segundo para que o timestamp da proxima migration seja diferente
          migration_template 'migrations/departamentos.rb', 'db/migrate/create_chat_departamentos.rb'
          sleep( 1.0 ) # Espera 1 segundo para que o timestamp da proxima migration seja diferente
          migration_template 'migrations/chats.rb', 'db/migrate/create_chats.rb'
          sleep( 1.0 ) # Espera 1 segundo para que o timestamp da proxima migration seja diferente
          migration_template 'migrations/mensagens.rb', 'db/migrate/create_chat_mensagens.rb'
          sleep( 1.0 ) # Espera 1 segundo para que o timestamp da proxima migration seja diferente
          migration_template 'migrations/sessions.rb', 'db/migrate/create_chat_sessions.rb'
          sleep( 1.0 ) # Espera 1 segundo para que o timestamp da proxima migration seja diferente
          migration_template 'migrations/atendente.rb', 'db/migrate/add_departamento_to_administrador.rb'
          sleep( 1.0 ) # Espera 1 segundo para que o timestamp da proxima migration seja diferente
          
          if yes? 'Gerar settings? Já tem no QW3Common.'
            migration_template 'migrations/settings.rb', 'db/migrate/create_settings.rb'
            sleep( 1.0 ) # Espera 1 segundo para que o timestamp da proxima migration seja diferente
          end
          
          if yes?( "Executar rake db:migrate?" )
          rake("db:create")
          rake("db:migrate")
        end
        
        unless yes? 'O usuário Administrador tem o atributo "type" (está preparado para herança)?'
            migration_template 'migrations/add_type_to_administrador.rb', 'db/migrate/add_type_to_administrador.rb'
            rake("db:migrate")
        end
        
      end
      
      def create_initializer_files
        if yes?( "Copiar initializers?" )
        # initializer não faz mal pra ninguem
        copy_file "initializers/configuracao_atendimento.rb", "config/initializers/configuracao_atendimento.rb"
        copy_file "initializers/inflections.rb", "config/initializers/qw3chat_inflections.rb"
      end
      
      def create_javascript_files
        if yes? 'Gerar JS?'
          copy_file "public/javascripts/chat.client.close.js", "public/javascripts/qw3chat/chat.client.close.js"
          copy_file "public/javascripts/chat.js", "public/javascripts/qw3chat/chat.js"
          copy_file "public/javascripts/chat.notify.js", "public/javascripts/qw3chat/chat.notify.js"
          copy_file "public/javascripts/chat.start.js", "public/javascripts/qw3chat/chat.start.js"
          copy_file "public/javascripts/chat.status.js", "public/javascripts/qw3chat/chat.status.js"
          copy_file "public/javascripts/chat.webkit.notification.js", "public/javascripts/qw3chat/chat.webkit.notification.js"
          copy_file "public/javascripts/jquery.cookie.js", "public/javascripts/qw3chat/jquery.cookie.js"
        end
      end
    
      def create_stylesheet_files
        if yes? 'Gerar CSS?'
          copy_file "public/stylesheets/application.css", "public/stylesheets/qw3chat/application.css"
          copy_file "public/stylesheets/backend.css", "public/stylesheets/qw3chat/backend.css"
          copy_file "public/stylesheets/chat.css", "public/stylesheets/qw3chat/chat.css"
          copy_file "public/stylesheets/frontend.css", "public/stylesheets/qw3chat/frontend.css"
        end
      end
      
      
      def copy_image_files
        if yes?( "Copiar arquivos?" )
          FileUtils.cp_r File.expand_path("../templates/public/images", __FILE__), "public/images/qw3chat"
        end
      end
      
      def copy_layout_files
        if yes? 'Gerar layouts?'
          copy_file 'layouts/backend.html.erb', 'app/views/layouts/qw3chat/backend.html.erb'
          copy_file 'layouts/backend-chat.html.erb', 'app/views/layouts/qw3chat/backend-chat.html.erb'
          copy_file 'layouts/frontend.html.erb', 'app/views/layouts/qw3chat/frontend.html.erb'
          copy_file 'layouts/frontend-chat.html.erb', 'app/views/layouts/qw3chat/frontend-chat.html.erb'
          copy_file 'layouts/login.html.erb', 'app/views/layouts/qw3chat/login.html.erb'
        end
      end
      
      def copy_18n_files
        if yes?( "Copiar arquivos de linguagem?" )
          copy_file 'locales/qw3chat.en.yml', 'config/locales/qw3chat.en.yml'
          copy_file 'locales/qw3chat.pt-BR.yml', 'config/locales/qw3chat.pt-BR.yml'
        end
      end
      
      def create_routes
        
        if yes? 'Gerar rotas?'
           
          route("
  # QW3Chat - Administrator
  namespace :administrator do

    resources :chats
    controller :chats do
      get '/novas_notificacoes'       => 'chats#novas_notificacoes'
      get '/chats/:id/atender'        => 'chats#atender'
      get '/chats/:id/finalizar'      => 'chats#finalizar'
      get '/chats/:id/visualizar'     => 'chats#visualizar'
    end

    resources :chat_atendentes
    resources :chat_departamentos

    resources :chat_sessions
    controller :chat_sessions do
      post 'chat_sessions/iniciar'       => 'chat_sessions#iniciar'
      post 'chat_sessions/finalizar'     => 'chat_sessions#finalizar'
    end

    controller :configuracao_atendimento do
      get 'configuracao_atendimento/editar'   => 'configuracao_atendimento#editar'
      post 'configuracao_atendimento/salvar'  => 'configuracao_atendimento#salvar'
    end

    controller :chat_mensagens do
      post '/atualiza_mensagens'  => 'chat_mensagens#atualiza_mensagens'
      post '/nova-mensagem'       => 'chat_mensagens#create'
    end

  end
          ")
        
          route("
  
  # QW3Chat - Frontend - Parte do cliente
  resources :chats
  controller :chats do
    post 'fechar_chat'  => 'chats#fechar'
  end

  resources :chat_clientes
  match '/chat_sessions/verificar_status' => 'chat_sessions#verificar_status'

  controller :chat_mensagens do
    post 'atualiza_mensagens' => 'chat_mensagens#atualiza_mensagens'
    post 'mensagens'          => :create
  end
      
                ")
        end
    
      end
    
    end
  end
end
