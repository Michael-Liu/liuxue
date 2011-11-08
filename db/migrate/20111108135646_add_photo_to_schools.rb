class AddPhotoToSchools < ActiveRecord::Migration
  def self.up
    add_column :schools, :photo, :string, :limit => 200
  end

  def self.down
    remove_column :schools, :photo
  end
end
