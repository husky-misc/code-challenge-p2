require 'rails_helper'

RSpec.describe Api::V1::DataController, type: :controller do

  describe "POST #store" do

    let(:valid_json_params) { { 
      input: [
        "1 2 3 4: 1,3",
        "1 2 3 5: 0,0"
      ]} }

    context 'when the input params are valid and the request headers are correct' do
      before do 
        request.content_type = 'application/json'
        request.headers["accept"] = 'application/json'
      end

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

    context 'when request format is not defined' do 
      it "returns http unsupported media type" do
        post :store, params: valid_json_params
        expect(response).to have_http_status(:unsupported_media_type)
      end
      
      it "does not create data" do
        expect do
          post :store, params: valid_json_params
        end.not_to change { Datum.count }
      end
    end

    context 'when content type is not defined' do 
      it "returns http unsupported media type" do
        post :store, params: valid_json_params
        expect(response).to have_http_status(:unsupported_media_type)
      end

      it "does not create data" do
        expect do
          post :store, params: valid_json_params
        end.not_to change { Datum.count }
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

      before do
        request.content_type = 'application/json'
        request.headers["accept"] = 'application/json'
      end

      it "returns http wrong format" do
        post :store, params: malformed_params
        expect(response).to have_http_status(:bad_request)
      end

      it "returns http wrong format" do
        post :store, params: empty_params
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "GET #compute" do
    let!(:data) { create_list(:datum, 2) }

    before do
      request.headers["accept"] = 'application/json'
      request.content_type = 'application/json'
    end

    it "returns http success" do
      get :compute
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("[11,11]")
    end

    it "flushes data" do
      expect do
        get :compute
      end.to change { Datum.count }.to(0)
    end
  end
end
