class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders, :id => false do |t|
      t.string :id
      t.integer :teacher_id
      t.integer :student_id
      t.integer :price, :default => 0
      t.integer :num, :default => 1
      t.integer :status
      t.datetime :pay_time
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
