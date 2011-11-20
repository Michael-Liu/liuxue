class AddCountryIdsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :country_ids, :string
  end

  def self.down
    remove_column :user, :country_ids
  end
end
