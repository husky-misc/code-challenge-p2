require 'rails_helper'

RSpec.describe Item do
  let(:attrs) do
    {
      array:[*1..4],
      circular_right_rotation: 2,
      index: 3
    }
  end
  let(:item) { Item.new(attrs) }

  describe '#initialize' do
    it 'sets #array' do
      expect(item.array).to eq([*1..4])
    end

    it 'sets #circular_right_rotation' do
      expect(item.circular_right_rotation).to eq(2)
    end

    it 'sets #index' do
      expect(item.index).to eq(3)
    end

    context 'given value is invalid' do
      let(:value) { 'invalid argument: 2,hi' }

      it 'raises ArgumentError' do
        expect do
          Item.new(value)
        end.to raise_error(ArgumentError)
      end
    end
  end

  describe '#result' do
    let(:samples) do
      [
        { array: [1, 2, 3, 4], circular_right_rotation: 1, index: 3, result: 3 },
        { array: [1, 2, 3, 5], circular_right_rotation: 0, index: 0, result: 1 },
        { array: [1, 2, 3, 4], circular_right_rotation: 2, index: 2, result: 1 },
        { array: [1], circular_right_rotation: 10, index: 0, result: 1 }
      ]
    end

    it 'resolves right rotation and get element by index' do
      samples.each do |sample|
        expected_result = sample[:result]
        item_attrs = sample.tap { |hash| hash.delete(:result) }

        item = Item.new(item_attrs)
        expect(item.result).to eq(expected_result)
      end
    end
  end
end
