class Province < ActiveRecord::Base
  class << self
    def cache
      $_app_cache.get_object "provinces", self
    end
  end
end
