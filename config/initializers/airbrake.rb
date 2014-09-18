Airbrake.configure do |config|
  config.api_key = Settings['errors.key']
  config.host    = Settings['errors.url']
  config.port    = 80
end
