require 'redis'
require_relative '../../lib/adapters/redis'

uri = URI.parse(ENV['REDIS_URL'])
Adapters::Redis.client = Redis.new(host: uri.host, port: uri.port, password: uri.password)