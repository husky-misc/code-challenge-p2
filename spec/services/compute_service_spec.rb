require 'rails_helper'

RSpec.describe ComputeService, type: :service do
  describe "#perform" do
    
    subject { ComputeService.new }

    context "when there is valid data with positive numbers to compute" do
      before do
        create(:datum, rotations: 0, index: 0) 
        create(:datum, rotations: 2, index: 1) 
        create(:datum, rotations: 5, index: 6) 
      end
      
      it "flushes all the data" do
        expect do
          subject.perform
        end.to change { Datum.count }.to(0)
      end

      it "returns an array with values" do
        expect(subject.perform).to eq([1,11, 2])
      end

      it "saves the results into the history" do
        expect do
          subject.perform
        end.to change { History.count }.to(1)
      end
    end

    context "when there is valid data with negative numbers to compute" do
      before do
        create(:datum, rotations: -1, index: -2) 
        create(:datum, rotations: -2, index: -5) 
      end

      it "returns an array with values" do
        expect(subject.perform).to eq([11, 9])
      end
    end

    context "when there is no data to compute" do
      it "returns an empty array" do
        expect(subject.perform).to eq([])
      end

      it "does not save into the history" do
        expect do
          subject.perform
        end.not_to change { History.count }
      end
    end
  end
end