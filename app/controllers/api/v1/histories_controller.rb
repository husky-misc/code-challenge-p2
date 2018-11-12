require 'will_paginate/array'

class Api::V1::HistoriesController < ApplicationController  
  def index
    @histories = History.all

    paginate json: @histories.as_json(only: [:content]), per_page: 5
  end

  def admin_index
    @histories = History.all
    paginate json: @histories, per_page: 20
  end

end