require 'redis'
require_relative '../../lib/adapters/redis'

uri = URI.parse(ENV['REDIS_URL'] || 'redis://rediscloud:LSU6lfjrPP3G8eFrtq4JuRg0sJ5xk8Sz@redis-10308.c91.us-east-1-3.ec2.cloud.redislabs.com:10308')
Adapters::Redis.client = Redis.new(host: uri.host, port: uri.port, password: uri.password)