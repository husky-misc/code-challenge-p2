require 'rails_helper'
require 'fakeredis'

RSpec.describe Api::V1::StoreController, type: :request do
  let(:path) { '/api/v1/store' }
  let(:params) do
    {
      input: [
        '1 2 3 4: 2,2',
        '1: 10,0'
      ]
    }.to_json
  end
  let(:headers) { { 'Content-Type' => 'application/json' } }

  describe '#create' do
    it 'returns success' do
      post path, params: params, headers: headers

      expect(response.status).to eq(204)
    end
    require 'fakeredis'

    it 'initializes Item`s correctly' do
      expect(Item).to receive(:new).with(array: [*1..4], circular_right_rotation: 2, index: 2).once.and_call_original
      expect(Item).to receive(:new).with(array: [1], circular_right_rotation: 10, index: 0).once.and_call_original

      post path, params: params, headers: headers
    end

    context 'given incorrectly input' do
      let(:params) do
        {
          input: [
            '1 2 3 test: 2,2',
            '1: 10,0'
          ]
        }.to_json
      end

      it 'returns unprocessable entity' do
        post path, params: params, headers: headers

        expect(response.status).to eq(422)
      end
    end

    context 'given occurs a not mapped error' do
      before do
        allow(Item).to receive(:new).and_raise(StandardError.new)
      end

      it 'returns internal server error' do
        post path, params: params, headers: headers

        expect(response.status).to eq(500)
      end
    end

    context 'given Content-Type is not informed' do
      let(:headers) { nil }

      it 'returns unsupported media type' do
        post path, params: params, headers: headers

        expect(response.status).to eq(415)
      end
    end

    context 'given Content-Type is unsupported' do
      let(:headers) { { 'Content-Type' => 'application/text' } }

      it 'returns unsupported media type' do
        post path, params: params, headers: headers

        expect(response.status).to eq(415)
      end
    end

    context 'given request with some suffix which not .json' do
      let(:path) { '/api/v1/store.xml' }

      it 'returns unsupported media type' do
        post path, params: params, headers: headers

        expect(response.status).to eq(415)
      end
    end
  end
end
