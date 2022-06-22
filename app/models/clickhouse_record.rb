class ClickhouseRecord < ActiveRecord::Base
  self.abstract_class = true

  def readonly?
    true
  end

  class << self
    def agent
      ClickHouse.connection()
    end

    def select_one
      agent.select_one(current_scope.to_sql)
    end

    def select_value
      agent.select_value(current_scope.to_sql)
    end

    def select_all
      agent.select_all(current_scope.to_sql)
    end

    def explain
      agent.explain(current_scope.to_sql)
    end
  end
end
