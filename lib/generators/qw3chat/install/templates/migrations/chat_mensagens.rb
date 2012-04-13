# -*- encoding : utf-8 -*-
class CreateChatMensagens < ActiveRecord::Migration
  def self.up
    create_table :chat_mensagens do |t|
      t.string :autor
      t.string :texto
      t.datetime :data
      t.integer :chat_id
    end
  end

  def self.down
    drop_table :chat_mensagens
  end
end
