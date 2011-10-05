# -*- encoding : utf-8 -*-
module Administrator
  module AdminHelper
    
    def corrige_tamanho_string(string, tamanho)
      return nil if string.nil?
      return "#{string[0, tamanho]}..." if string.size > tamanho
      return nil
    end
  
  end
end
