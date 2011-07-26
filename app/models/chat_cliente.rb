# -*- encoding : utf-8 -*-
class ChatCliente < ActiveRecord::Base
  
  has_one :chat

  cattr_reader :per_page
  @@per_page = 10

end
