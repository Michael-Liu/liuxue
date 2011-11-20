class CreateTableCountriesTeachers < ActiveRecord::Migration
  def self.up
    create_table :countries_teachers, :id => false do |t|
      t.integer :teacher_id
      t.string :country_id
    end
  end

  def self.down
    drop_table :countries_teachers
  end
end
