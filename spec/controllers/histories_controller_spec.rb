require 'rails_helper'

RSpec.describe Api::V1::HistoriesController, type: :controller do

  before do
    create_list(:history, 3)
    request.content_type = 'application/json'
    request.headers["accept"] = 'application/json'
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