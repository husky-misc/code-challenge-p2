class Api::V1::DataController < ApplicationController
  before_action :validate_data_params, only: [:store]
  
  def store
    @data = Datum.create(data_params)
    if @data
      render json: @data, status: 201
    else
      render json: @data.errors
    end
  end

  def compute
    @data = Datum.all
    computed_data = @data.map do |d| 
      rotated = d.content.rotate d.rotations
      rotated[d.index] 
    end
    render json: {result: computed_data}
  end

  private
  def validate_data_params
    begin
      data_params
    rescue
      render json: {msg:  'Wrong input format'}, status: :bad_request
    end
  end

  def data_params
    format_input_params(params.require(:input))
  end

  def format_input_params(input_params)
    input_params.map do |i|
      format_input_param(i)
    end
  end
  
  def format_input_param(input_params)
    content, extra = input_params.split(":")
    rotations, index = extra.split(",")
    {
      content: content.split(" ").map(&:to_i), 
      rotations: rotations.to_i, 
      index: index.to_i
    }
  end

end
