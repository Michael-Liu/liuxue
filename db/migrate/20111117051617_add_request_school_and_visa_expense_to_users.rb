class AddRequestSchoolAndVisaExpenseToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :request_school_expense, :integer
    add_column :users, :request_visa_expense, :integer
  end

  def self.down
    remove_column :users, :request_school_expense
    remove_column :users, :request_visa_expense
  end
end
