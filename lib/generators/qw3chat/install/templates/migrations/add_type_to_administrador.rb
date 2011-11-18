class AddTypeToAdministrador < ActiveRecord::Migration
  def self.up
    add_column :administradores, :type, :string, :default => 'Administrador'
  end
  
  def self.down
    remove_column :administradores, :type
  end
end
