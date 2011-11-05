class ChangeCountriesColumnIdFromIntegerToString < ActiveRecord::Migration
  def self.up
    change_column :countries, :id, :string, :limit => 50
  end
  def self.down
    change_column :countries, :id, :integer
  end
end
