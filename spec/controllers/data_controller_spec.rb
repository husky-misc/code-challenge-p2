require 'rails_helper'

RSpec.describe Api::V1::DataController, type: :controller do

  describe "POST #store" do

    let(:valid_json_params) { { input: [
      "1 2 3 4: 1,3",
      "1 2 3 5: 0,0"
    ]} }

    context 'when the input params are valid and the content type is json' do

      before { request.content_type = 'application/json' }

      it "returns http success" do
        post :store, params: valid_json_params
        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:created)
      end

      it "creates new data" do
        expect do
          post :store, params: valid_json_params
        end.to change { Datum.count }.by(2)
      end
    end

    context 'when the input params are valid and the content type is not defined' do 
      it "returns http unsupported media type" do
        post :store, params: valid_json_params
        expect(response).to have_http_status(:unsupported_media_type)
      end
    end

    context 'when the input params are valid and the content type is not json' do
      it "returns http unsupported media type" do
        request.content_type = 'text/html' 
        post :store, params: valid_json_params
        expect(response).to have_http_status(:unsupported_media_type)
      end
    end 

    context 'when the input params are invalid' do
      let!(:malformed_params) { { input: [
        "1 2 3 4",
        "5 6 7 8"
      ]} }
  
      let!(:empty_params) { { } }

      it "returns http wrong format" do
        request.content_type = 'application/json'
        post :store, params: malformed_params
        expect(response).to have_http_status(:bad_request)
      end

      it "returns http wrong format" do
        request.content_type = 'application/json'
        post :store, params: empty_params
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
