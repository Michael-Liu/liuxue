class Major < ActiveRecord::Base
  class << self

    def kv
      cache.collect {|c| [c.name, c.id] }
    end

    def cache
      $_app_cache.get_object "majors", self
    end

  end
end
