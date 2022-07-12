require 'connection_pool'

ClickHouse.config do |config|
  config.logger = Rails.logger
  config.assign(Rails.application.config_for('click_house'))
end

ClickHouse.connection = ConnectionPool.new(size: 2) do
  ClickHouse::Connection.new(ClickHouse.config)
end

# dummy singleton class to wrap the connection pool scope
# https://refactoring.guru/design-patterns/singleton/ruby/example#example-1 
class ClickHouseConnectionClass
  @instance = new

  private_class_method :new

  def self.instance
    @instance
  end

  def ping
    ClickHouse.connection.with do |conn|
      conn.ping
    end
  end

  def select_all(sql)
    ClickHouse.connection.with do |conn|
      conn.select_all(sql)
    end
  end

  def select_one(sql)
    ClickHouse.connection.with do |conn|
      conn.select_one(sql)
    end
  end

  def explain(sql)
    ClickHouse.connection.with do |conn|
      conn.explain(sql)
    end
  end

  def execute(sql)
    ClickHouse.connection.with do |conn|
      conn.execute(sql)
    end
  end
end

ClickHouseConnection = ClickHouseConnectionClass.instance
