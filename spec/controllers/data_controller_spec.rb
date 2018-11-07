require 'rails_helper'

RSpec.describe Api::V1::DataController, type: :controller do

  describe "POST #store" do
    let!(:valid_json_params) { { input: [
      "1 2 3 4: 1,3",
      "1 2 3 5: 0,0"
    ]} }

    it "returns http success" do
      request.content_type = 'application/json'
      post :store, params: valid_json_params
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:created)
    end
  end
end
