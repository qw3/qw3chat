# -*- encoding : utf-8 -*-
class ChatDepartamento < ActiveRecord::Base
  has_many :chats
  
  validates :nome, :alias, :presence => true
  
end
