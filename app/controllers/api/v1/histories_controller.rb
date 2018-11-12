class Api::V1::HistoriesController < ApplicationController  
  
  def index
    @histories = History.all
    paginate json: @histories.as_json(only: [:content])
  end

  def admin_index
    @histories = History.all
    paginate json: @histories
  end

end