# -*- encoding : utf-8 -*-
module Administrator
  module AdminHelper
    
    # enable i18n in will_paginate
    include WillPaginate::ViewHelpers
    
    def corrige_tamanho_string(string, tamanho)
      return nil if string.nil?
      return "#{string[0, tamanho]}..." if string.size > tamanho
      return nil
    end
  
    def will_paginate_with_i18n(collection = nil, options = {})
      will_paginate collection, options.merge(:previous_label => I18n.t(:previous), :next_label => I18n.t(:next))
    end
    
  end
end