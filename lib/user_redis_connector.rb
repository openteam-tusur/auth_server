class UserRedisConnector
  include Singleton

  def get(key)
    connection.hgetall("#{namespace}:#{key}")
  end

  def set(key, options)
    connection.hmset("#{namespace}:#{key}", *options)
  end

  def connection
    @connection ||= Redis.new(:url => Settings['users_storage.url'], :driver => :hiredis)
  end

  def namespace
    'user'
  end
end
