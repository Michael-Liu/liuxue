class AddProvinceIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :province_id, :integer
  end

  def self.down
    remove_column :users, :province_id
  end
end
