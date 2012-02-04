require 'em-hiredis'
require 'sinatra/async'

class AsyncRedis < Sinatra::Base
  register Sinatra::Async

  def redis
    @@redis ||= EM::Hiredis.connect
  end

  aget('/') do
    redis.incr('test') do
      redis.get('test') {|r| body r }
    end
  end
end