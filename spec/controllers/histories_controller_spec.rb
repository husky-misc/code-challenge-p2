require 'rails_helper'

RSpec.describe Api::V1::HistoriesController, type: :controller do
  
  let!(:api_key) { ApiKey.create!(access_token: 'afbadb4ff8485c0adcba486b4ca90cc4').access_token }

  before do
    create_list(:history, 3)
    request.content_type = 'application/json'
    request.headers["accept"] = 'application/json'
    request.headers["Authorization"] = api_key
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #admin_index" do
    it "returns http success" do
      get :admin_index
      expect(response).to have_http_status(:ok)
    end
  end

end