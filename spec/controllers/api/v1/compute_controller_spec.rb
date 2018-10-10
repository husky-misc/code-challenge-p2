require 'rails_helper'
require 'fakeredis'

RSpec.describe Api::V1::ComputeController, type: :request do
  let(:path) { '/api/v1/compute' }

  describe '#show' do
    before(:each) do
      repository = ResultRepository.new
      repository.save(123)
      repository.save(321)
    end

    it 'returns success' do
      get path

      expect(response.status).to eq(200)
    end

    it 'returns results computed' do
      get path

      expect(response.body).to eq('{"data":{"results":["123","321"]}}')
    end

    it 'clean results after one request' do
      get path
      get path

      expect(response.body).to eq('{"data":{"results":[]}}')
    end

    context 'given occurs a not mapped error' do
      before do
        allow(ResultRepository).to receive(:new).and_raise(StandardError.new)
      end

      it 'returns internal server error' do
        get path

        expect(response.status).to eq(500)
      end
    end
  end
end
