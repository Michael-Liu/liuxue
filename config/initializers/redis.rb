require 'redis'

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
$_app_cache.set_object "majors", Major.all
$_app_cache.set_object "countries", Country.all
$_app_cache.set_object "provinces", Province.all
