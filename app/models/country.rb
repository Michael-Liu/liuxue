class Country < ActiveRecord::Base

  has_and_belongs_to_many :services

  # class << self
  #   def cache
  #     $_app_cache.get_object "countries", self
  #   end
  # end
end
