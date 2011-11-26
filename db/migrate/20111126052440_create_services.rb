class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :name
      t.integer :expense
      t.integer :user_id
      t.string :type
      t.integer :orders_count, :default => 0
      t.integer :successful_orders_count, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
