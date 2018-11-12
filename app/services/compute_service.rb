class ComputeService

  def initialize(ip = nil)
    @ip = ip
  end

  def perform
    compute_data
    save_history
    flush_data
    @computed_data
  end

  private  
  def compute_data
    @computed_data = Datum.all.map do |d| 
      rotated = d.content.rotate -d.rotations
      rotated[d.index] 
    end
  end

  def save_history
    unless @computed_data.empty?
      History.create({content: @computed_data, ip: @ip}) 
    end
  end

  def flush_data
    Datum.delete_all
  end
end