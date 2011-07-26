# -*- encoding : utf-8 -*-
class Administrator::ConfiguracaoAtendimentoController < Administrator::AdminController

  before_filter :config_menu_detalhes
  
  def editar
  end

  def salvar

    logo_upload params[:logo_upload]

    ConfiguracaoAtendimento.nome_empresa    = params[:nome_empresa]    
    ConfiguracaoAtendimento.email_padrao    = params[:email_padrao]
    ConfiguracaoAtendimento.cor_topo        = params[:cor_topo]    
    ConfiguracaoAtendimento.texto_online    = params[:texto_online]
    ConfiguracaoAtendimento.texto_offline   = params[:texto_offline]
    
    respond_to do |format|
      format.html {redirect_to '/administrator/configuracao_atendimento/editar', :notice => 'Configurações salvas com sucesso' }
    end
    
  end
  
  private 
    def logo_upload(arquivo)
      
      File.delete ConfiguracaoAtendimento.logo if File.exists?(ConfiguracaoAtendimento.logo)
      
      if(!arquivo.nil?)
        caminho = File.join('public', 'images', 'configuracoes', 'logo')
        FileUtils.mkdir_p(caminho) if( !File.directory?(caminho) ) # cria o diretório se não existe
        nome_arquivo = rand(9).to_s + rand(9).to_s + rand(9).to_s + arquivo.original_filename
        File.open(File.join(caminho, nome_arquivo), "wb") { |f| f.write(arquivo.read) }
        ConfiguracaoAtendimento.logo = 'configuracoes/logo/' + nome_arquivo
      end
    end

end
