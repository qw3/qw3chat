# -*- encoding : utf-8 -*-
class CreateChatDepartamentos < ActiveRecord::Migration
  def self.up
    create_table :chat_departamentos do |t|
      t.string :nome
      t.string :alias
      t.string :email
    end
  end

  def self.down
    drop_table :chat_departamentos
  end
end
