class RenameCountriesTeachersToCountriesServices < ActiveRecord::Migration
  def self.up
    rename_table :countries_teachers, :countries_services
  end

  def self.down
    rename_table :countries_services, :countries_teachers
  end
end
