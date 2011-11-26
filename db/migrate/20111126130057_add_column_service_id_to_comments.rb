class AddColumnServiceIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :service_id, :integer
  end

  def self.down
    remove_column :comments, :service_id
  end
end
