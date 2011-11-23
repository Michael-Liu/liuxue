class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :order_id
      t.integer :attitude
      t.integer :efficiency
      t.string :body
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
