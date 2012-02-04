require 'em-hiredis'
require 'sinatra/async'

STDOUT.sync = true

class AsyncRedis < Sinatra::Base
  register Sinatra::Async

  def connect!
    puts "connecting to redis"
    EM::Hiredis.connect
  end

  def redis
    @@redis ||= connect!
  end

  aget('/') do
    key = 'test'
    redis.incr(key) do
      redis.get(key) { |r| body r }
    end
  end
end

AsyncRedis.run!
