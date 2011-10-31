class AddAddressToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :address, :string, :limit => 50
    add_column :users, :im, :string, :limit => 50
    add_column :users, :telephone, :string, :limit => 20
    add_column :users, :about, :string, :limit => 500
  end

  def self.down
    remove_column :users, :address
    remove_column :users, :im
    remove_column :users, :telephone
    remove_column :users, :about
  end
end
