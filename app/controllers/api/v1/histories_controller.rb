class Api::V1::HistoriesController < ApplicationController  
  
  def index
    @histories = History.all
    render json: @histories.as_json(only: [:content])
  end

  def admin_index
    @histories = History.all
    render json: @histories
  end

end