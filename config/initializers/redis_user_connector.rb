Settings.define 'redis_user_connector', :required => true
Settings.resolve!

RedisUserConnector.connect Settings['redis_user_connector']
