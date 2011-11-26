require 'redis'
require 'active_record'

module Config
  class Redis
    @@host = "127.0.0.1"
    @@port = "6379"
    @@db   = "0"
    @@cache = nil

    class << self

      def init
        @@cache = ::Redis.new(:host => @@host, :port => @@port)
      end

      def server
        "redis://#{@@host}:#{@@port}/#{@@db}"
      end

      def get_object(key, cls)
        # puts "cache:::#{@@cache.get(key)}"
        JSON.parse(@@cache.get(key), :symbolize_names => true, 
                   :object_class => cls)
      end

      def set_object(key, object)
        @@cache.set(key, object.to_json)
      end

    end

  end
end

$_app_cache = Config::Redis
$_app_cache.init

# init model data that need to cached
[Major, Country, Province].each do |cls|

  $_app_cache.set_object cls.table_name, cls.all

  # define cache class method
  # cls.class_eval do
  #   class << self
  #     def cache 
  #       $_app_cache.get_object(self.table_name, self)
  #     end
  #   end
  # end
  # cls.instance_eval do 
  #   def cache_list
  #     $_app_cache.get_object(self.table_name, self) || []
  #   end
  # end
end

ActiveRecord::Base.instance_eval do
  def cache_list
    $_app_cache.get_object(self.table_name, self) || []
  end
end

