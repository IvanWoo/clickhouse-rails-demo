ClickHouse.config do |config|
  config.logger = Logger.new(STDOUT)
  config.adapter = :net_http
  config.database = 'test'
  config.url = 'http://localhost:8123'
  config.timeout = 60
  config.open_timeout = 3
  config.ssl_verify = false
  config.headers = {}

  # or provide connection options separately
  # config.scheme = 'http'
  # config.host = 'localhost'
  # config.port = 'port'

  # if you use HTTP basic Auth
  config.username = 'analytics'
  config.password = 'admin'

  # if you want to add settings to all queries
  config.global_params = { mutations_sync: 1 }
end
