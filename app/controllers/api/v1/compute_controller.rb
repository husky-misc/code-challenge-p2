module Api::V1
  class ComputeController < ApplicationController
    def show
      results = ResultRepository.new.all

      render(json: {
        data: {
          results: results
        }
      }, status: :ok)
    rescue StandardError => error
      render(nothing: true, status: :internal_server_error)
    end
  end
end
