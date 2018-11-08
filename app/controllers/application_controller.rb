class ApplicationController < ActionController::API
  before_action :restrict_content_type

  private
  def restrict_content_type
      render json: {msg:  'Content-Type must be application/json'}, status: 415 unless request.content_type == 'application/json'
  end
end
