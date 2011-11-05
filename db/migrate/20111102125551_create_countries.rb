class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries, :id => false do |t|
      t.string :id, :limit => 50
      t.string :code, :limit => 50
      t.string :name, :limit => 50
      # t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
