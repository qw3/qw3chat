# -*- encoding : utf-8 -*-
class CreateClientes < ActiveRecord::Migration
  def self.up
    create_table :chat_clientes do |t|
      t.string :nome
      t.string :email
      t.string :telefone
    end
  end

  def self.down
    drop_table :chat_clientes
  end
end
