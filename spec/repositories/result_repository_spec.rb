require 'rails_helper'

RSpec.describe ResultRepository do
  let(:adapter) { double }
  let(:key) { 'RESULTS' }
  subject(:repository) { ResultRepository.new(adapter) }

  describe '#all' do
    before(:each) do
      allow(adapter).to receive(:get_all).with(key).and_return(['test', 'element'])
      allow(adapter).to receive(:flush).with(key).and_return(true)
    end

    it 'returns elements from adapter#get_all' do
      response = repository.all

      expect(response).to eq(['test', 'element'])
    end

    it 'calls adapter#flush' do
      expect(adapter).to receive(:flush).with(key)

      repository.all
    end
  end

  describe '#save' do
    let(:result) { 'result' }

    before(:each) do
      allow(adapter).to receive(:add).with(key, result).and_return(true)
    end

    it 'calls adapter#save' do
      expect(adapter).to receive(:add)

      repository.save(result)
    end
  end
end
