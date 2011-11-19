class School < ActiveRecord::Base
  # rank == 0 没有足够的排名信息

  def expense_show
    "#{Country.cache_list.find { |c| c.id == self.country_id }.currency} #{self.expense.to_s}"
  end

  def url_show
    "http://colleges.usnews.rankingsandreviews.com/best-colleges/#{self.url}"
  end

  def photo_show
    "/photos/schools/meiguo/#{self.photo}"
  end
end
