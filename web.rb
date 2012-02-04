require 'em-hiredis'
require 'sinatra/async'

class AsyncRedis < Sinatra::Base
  register Sinatra::Async

  def redis
    @@redis ||= EM::Hiredis.connect
  end

  aget('/') do
    key = 'test'
    redis.incr(key) do
      redis.get(key) { |r| body r }
    end
  end
end