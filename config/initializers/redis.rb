$redis = Redis.new(:driver => :hiredis)

redis_host = Rails.application.secrets.redis && Rails.application.secrets.redis['host'] || 'localhost'
redis_port = Rails.application.secrets.redis && Rails.application.secrets.redis['port'] || 6379
REDIS = Redis.new(host: redis_host, port: redis_port.to_i)