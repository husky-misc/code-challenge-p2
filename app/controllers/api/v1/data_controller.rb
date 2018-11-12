class Api::V1::DataController < ApplicationController
  before_action :validate_data_params, only: [:store]
  
  def store
    @data = DataService.new(data_params).perform
    render json: { success: @data.success, errors: @data.errors }, status: 201
  end

  def compute
    computer = ComputeService.new(request.remote_ip)
    result = computer.perform
    render json: {result: result}
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
      content: content.split(" ").map { |i| Integer(i) }, 
      rotations: Integer(rotations), 
      index: Integer(index)
    }
  end

end
