# require 'rpush'

Rpush.configure do |config|

  # Supported clients are :active_record and :redis
  config.client = :active_record

  # Options passed to Redis.new
  # config.redis_options = {}

  # Frequency in seconds to check for new notifications.
  config.push_poll = 2
  config.batch_size = 100
  # Path to write PID file. Relative to current directory unless absolute.
  config.pid_file = 'tmp/rpush.pid'
  config.log_file = 'log/rpush.log'
  config.log_level = (defined?(Rails) && Rails.logger) ? Rails.logger.level : ::Logger::Severity::INFO

end

if (!Rpush::Gcm::App.find_by_name("teamwork_notif"))
  app = Rpush::Gcm::App.new 
  app.name = "teamwork_notif"
  app.auth_key = "AAAAxpNT2kY:APA91bGkpeB0aPl_-gz4amjZhKV6VrZj_8dsNoAL2pYEqnMIVzd-8H8QJs3fmudpXGcXzpRX1vF7jhVnoM2y9aCagkD4qpiLCnrFgR69YLzw9DczxAT9isF7jEpUbwezKtXMJUPnZ2S2"
  app.connections = 1
  app.save!
end 

Rpush.reflect do |on|
end
