class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.integer :status, :default => 1
      t.string :body, :limit => 500
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
