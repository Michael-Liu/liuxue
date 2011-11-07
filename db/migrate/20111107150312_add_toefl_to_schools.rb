class AddToeflToSchools < ActiveRecord::Migration
  def self.up
    add_column :schools, :toefl, :float
    add_column :schools, :ielts, :float
    add_column :schools, :gmat, :float
  end

  def self.down
    remove_column :schools, :toefl
    remove_column :schools, :ielts
    remove_column :schools, :gmat
  end
end
