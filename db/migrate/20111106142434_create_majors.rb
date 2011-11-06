class CreateMajors < ActiveRecord::Migration
  def self.up
    create_table :majors, :id => false do |t|
      t.string :id, :limit => 50
      t.string :code, :limit => 50
      t.string :name, :limit => 50
    end
  end

  def self.down
    drop_table :majors
  end
end
