class ApplicationController < ActionController::API
  before_action :restrict_content_type, :restrict_format
  private
  def restrict_content_type
    unless request.content_type == 'application/json'
      render json: {msg:  'Content-Type must be application/json'}, status: 415 
    end
  end

   def restrict_format
      unless request.format.json? or request.format.symbol.nil?
        binding.pry
        render json: {msg:  'Format must be json'}, status: 415  
      end
  end
end
