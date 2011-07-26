# -*- encoding : utf-8 -*-
class ChatDepartamento < ActiveRecord::Base
  has_many :chats
  
  validates :nome, :alias, :presence => true
  
  cattr_reader :per_page
  @@per_page = 10
  
end
