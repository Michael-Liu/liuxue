class AddOrdersCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :orders_count, :integer, :default => 0
    add_column :users, :successful_orders_count, :integer, :default => 0
  end

  def self.down
    remove_column :users, :orders_count
    remove_column :users, :successful_orders_count
  end
end
