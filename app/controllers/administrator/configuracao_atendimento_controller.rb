# -*- encoding : utf-8 -*-
class Administrator::ConfiguracaoAtendimentoController < Administrator::AdminController

  before_filter :config_menu_detalhes
  
  def editar
    respond_to do |format|
      format.html
    end
  end

  def salvar

    logo_upload params[:logo_upload]

    Settings['QW3CHAT.nome_empresa']    = params[:nome_empresa]    
    Settings['QW3CHAT.email_padrao']    = params[:email_padrao]
    Settings['QW3CHAT.cor_topo']        = params[:cor_topo]    
    Settings['QW3CHAT.texto_online']    = params[:texto_online]
    Settings['QW3CHAT.texto_offline']   = params[:texto_offline]
    
    respond_to do |format|
      format.html {redirect_to '/administrator/configuracao_atendimento/editar', :notice => 'Configurações salvas com sucesso' }
    end
    
  end
  
  private 
    def logo_upload(arquivo)
      
      unless Settings['QW3CHAT.logo'].nil?
        File.delete Settings['QW3CHAT.logo'] if File.exists?(Settings['QW3CHAT.logo'])
      end
      
      if(!arquivo.nil?)
        caminho = File.join('public', 'images', 'configuracoes', 'logo')
        FileUtils.mkdir_p(caminho) if( !File.directory?(caminho) ) # cria o diretório se não existe
        nome_arquivo = rand(9).to_s + rand(9).to_s + rand(9).to_s + arquivo.original_filename
        File.open(File.join(caminho, nome_arquivo), "wb") { |f| f.write(arquivo.read) }
        Settings['QW3CHAT.logo'] = '/images/configuracoes/logo/' + nome_arquivo
      end
    end

end
