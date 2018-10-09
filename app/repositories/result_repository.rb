class ResultRepository
  KEY = 'RESULTS'.freeze

  def initialize(redis_adapter = Adapters::Redis)
    @adapter = redis_adapter
  end

  def all
    @adapter.get_all(KEY)
    @adapter.flush(KEY)
  end

  def save(result)
    @adapter.add(KEY, result)
  end
end
