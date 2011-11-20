class RemoveCountryIdsFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :country_ids
  end

  def self.down
    add_column :users, :country_ids, :string
  end
end
