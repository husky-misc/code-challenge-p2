module Adapters
  class Redis
    class << self
      attr_writer :client
    end

    def self.add(key, values)
      @client.rpush(key, values)
    end

    def self.get_all(key)
      @client.lrange(key, 0, -1)
    end

    def self.flush(key)
      @client.del(key)
    end
  end
end