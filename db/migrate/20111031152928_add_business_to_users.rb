class AddBusinessToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :business, :string, :limit => 20
  end

  def self.down
    remove_column :users, :business
  end
end
