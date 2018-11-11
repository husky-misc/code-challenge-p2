class ComputeService

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
    History.create({content: @computed_data}) unless @computed_data.empty?
  end

  def flush_data
    Datum.delete_all
  end
end