class Country < ActiveRecord::Base
  class << self
    def cache
      $_app_cache.get_object "countries", self
    end
  end
end
