class ResultRepository
  KEY = 'RESULTS'.freeze

  def initialize(adapter = Adapters::Redis)
    @adapter = adapter
  end

  def all
    list = @adapter.get_all(KEY)
    @adapter.flush(KEY)

    list
  end

  def save(result)
    @adapter.add(KEY, result)
  end
end
