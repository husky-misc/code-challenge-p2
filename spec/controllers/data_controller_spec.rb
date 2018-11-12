require 'rails_helper'

RSpec.describe Api::V1::DataController, type: :controller do

  let!(:api_key) { ApiKey.create!(access_token: 'afbadb4ff8485c0adcba486b4ca90cc4').access_token }

  describe "POST #store" do

    let(:valid_json_params) { { 
      input: [
        "1 2 3 4: 1,3",
        "1 2 3 5: 0,0"
      ]} }

    context 'when a authorization header is not defined' do
      it "returns http unauthorized" do
        post :store, params: valid_json_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when the input params are valid and the request headers are correct' do
      before do 
        request.content_type = 'application/json'
        request.headers["accept"] = 'application/json'
        request.headers["Authorization"] = api_key
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
      before { request.headers["Authorization"] = api_key }
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
        request.headers["Authorization"] = api_key
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
        request.headers["Authorization"] = api_key
        post :store, params: valid_json_params
        expect(response).to have_http_status(:unsupported_media_type)
      end
    end 

    context 'when the input params format is invalid' do
      let!(:malformed_params) { { input: [
        "1 2 3 4",
        "5 6 7 8"
      ]} }

      before do
        request.content_type = 'application/json'
        request.headers["accept"] = 'application/json'
        request.headers["Authorization"] = api_key
      end

      it "returns http bad request" do
        post :store, params: malformed_params
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "when the input is text" do
      let!(:text_params) { { input: [
        "a b c d: b, a"
      ]} }

      before do
        request.content_type = 'application/json'
        request.headers["accept"] = 'application/json'
        request.headers["Authorization"] = api_key
      end

      it "returns http bad request" do
        post :store, params: text_params
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "when the input is empty" do
      before do
        request.content_type = 'application/json'
        request.headers["accept"] = 'application/json'
        request.headers["Authorization"] = api_key
      end

      it "returns http bad request" do
        post :store, params: { } 
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "GET #compute" do
    let!(:data) { create_list(:datum, 2) }

    before do
      request.headers["accept"] = 'application/json'
      request.content_type = 'application/json'
      request.headers["Authorization"] = api_key
    end

    it "returns http success" do
      get :compute
      expect(response).to have_http_status(:ok)
    end

    it "saves the request's IP in History" do
      get :compute
      expect(History.first.ip).to eq(request.remote_ip)
    end
  end
end
