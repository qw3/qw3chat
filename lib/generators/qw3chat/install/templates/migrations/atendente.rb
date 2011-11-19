# -*- encoding : utf-8 -*-
class AddDepartamentoToAdministrador < ActiveRecord::Migration
  def self.up
    add_column :administradores, :chat_departamento_id, :integer
  end
  
  def self.down
    remove_column :administradores, :chat_departamento_id
  end
end
