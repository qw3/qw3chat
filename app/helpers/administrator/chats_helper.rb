# -*- encoding : utf-8 -*-
module Administrator
  module ChatsHelper
    
    def nome_chat_index(status)
      if status.nil?
        return 'Todos os atendimentos'
      end
      case status.to_i
      when Chat::ESPERANDO then
        return 'Clientes esperando atendimento'
      when Chat::FINALIZADO then
        return 'Atendimentos finalizados'
      when Chat::EM_ATENDIMENTO then
        return 'Atendimentos em andamento'
      end
    end
    
    
    def historico_chat_formatado(s)
      linhas = s.split("\n")
      retorno = []
      linhas.each do |mensagem|
        horario = mensagem.match(/(\(|\[).+(\)|\])/)
        if !horario.nil?
          horario_obj = Time.parse(horario[0])
          retorno.push( mensagem.gsub(/(\(|\[).+(\)|\])/, "(#{horario_obj.strftime('%d/%m/%Y %H:%M:%S')})<span>").gsub("::::", "</span>:") )
        end
      end
      return simple_format retorno.join '<br />'
    end
      
    
  end
end
