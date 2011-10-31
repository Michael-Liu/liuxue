class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.integer :user_id
      t.integer :total_amount, :default => 0
      t.integer :available_amount, :default => 0
      t.integer :freeze_amount, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
