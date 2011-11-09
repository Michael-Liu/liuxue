class School < ActiveRecord::Base

  def expense_show
    Country.cache.find { |c| c.id == self.country_id }.currency + self.expense.to_s
  end
end
