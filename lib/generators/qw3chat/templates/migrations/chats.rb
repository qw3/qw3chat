# -*- encoding : utf-8 -*-
class CreateChats < ActiveRecord::Migration
  def self.up
    create_table :chats do |t|
      t.integer :cliente_id
      t.integer :atendente_id
      t.integer :status
      t.datetime :inicio
      t.integer :departamento_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :chats
  end
end
