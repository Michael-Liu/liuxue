class RenameColumnTeacherIdToServiceIdFromCountriesServices < ActiveRecord::Migration
  def self.up
    rename_column :countries_services, :teacher_id, :service_id
  end

  def self.down
    rename_column :countries_services, :service_id, :teacher_id
  end
end
