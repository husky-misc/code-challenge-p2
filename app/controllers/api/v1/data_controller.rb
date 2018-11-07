class Api::V1::DataController < ApplicationController
  
  def store
    @data = Datum.create(data_params)
    if @data
      render json: @data, status: 201
    else
      render json @data.errors
    end
  end

  def data_params
    filter_input_params(params.require(:input))
  end

  def filter_input_params(input_params)
    input_params.map do |i|
      filter_input_param(i)
    end
  end
  
  def filter_input_param(input_params)
    content, extra = input_params.split(":")
    rotations, index = extra.split(",")
    {
      content: content.split(" ").map(&:to_i), 
      rotations: rotations.to_i, 
      index: index.to_i
    }
  end

end
