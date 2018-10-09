require 'rails_helper'

RSpec.describe Adapters::Redis do
  let(:key) { 'key' }
  let(:field) { 'field' }
  let(:value) { 50 }
  subject(:adapter) { Adapters::Redis }

  describe '#add' do
    it 'calls client#rpush' do
      expect_any_instance_of(Redis).to receive(:rpush).with(key, value)

      adapter.add(key, value)
    end
  end

  describe '#get_all' do
    it 'calls client#lrange' do
      expect_any_instance_of(Redis).to receive(:lrange).with(key, 0, -1)

      adapter.get_all(key)
    end
  end

  describe '#flush' do
    it 'calls client#del' do
      expect_any_instance_of(Redis).to receive(:del).with(key)

      adapter.flush(key)
    end
  end
end