# -*- encoding : utf-8 -*-
class CreateSessions < ActiveRecord::Migration
  def self.up
    create_table :chat_sessions do |t|
      t.date :dia
      t.time :entrada
      t.time :saida
      t.integer :usuario_id
    end
  end

  def self.down
    drop_table :chats
  end
end
