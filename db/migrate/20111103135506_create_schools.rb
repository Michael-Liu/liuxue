class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.string :country_id, :limit => 50
      t.string :name, :limit => 50
      t.string :description, :limit => 500
      t.string :url, :limit => 100
      t.string :address, :limit => 100
      t.integer :expense
      t.integer :rank
      t.float :gre
      t.float :gpa
      t.timestamps
    end
  end

  def self.down
    drop_table :schools
  end
end
