class DataService

  def initialize(params)
    @params = params
  end

  def perform
    @data = Datum.create(@params)
    self
  end

  def errors
    @data.select(&:invalid?).map { |d| d.errors }
  end

  def success
    @data.reject(&:invalid?)
  end

end