# -*- encoding : utf-8 -*-
class ChatDepartamento < ActiveRecord::Base
  
  include BrHelper
  
  has_many :chats
  
  validates :nome, :presence => true
  
  before_save :montar_alias
  after_destroy :apagar_atendentes
  after_destroy :apagar_chats
  
  def montar_alias
    self.alias = create_alias self.alias, self.nome
  end
  
  def apagar_atendentes
    ChatAtendente.where(:chat_departamento_id => self.id).each do |atendente|
      atendente.destroy
    end
  end
  
  def apagar_chats
    Chat.where(:departamento_id => self.id).each do |chat|
      chat.destroy
    end
  end
  
end
