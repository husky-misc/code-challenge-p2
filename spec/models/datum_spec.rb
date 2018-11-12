require 'rails_helper'

RSpec.describe Datum, type: :model do
  it { is_expected.to be_mongoid_document }

  describe ".create" do
    context "when the params are valid and within limits" do
      it "creates a new record" do
        expect do
          Datum.create({content: [1,2, 4,5,6,7], index: 5, rotations: 99999})
        end.to change { Datum.count }.by(1)
      end
    end

    context "when index is bigger than content length size" do
      it "does not save the invalid record" do
        expect do
          Datum.create({content: [1,2, 4,5,6,7], index: 11, rotations:1})
        end.not_to change { Datum.count }
      end
    end

    context "when a content number is bigger than 500" do
      it "does not save the invalid record" do
        expect do
          Datum.create({content: [501, 0], index: 0, rotations:1})
        end.not_to change { Datum.count }
      end
    end

    context "when the rotations number is bigger than 99999" do
      it "does not save the invalid record" do
        expect do
          Datum.create({content: [10, 0], index: 0, rotations:100000})
        end.not_to change { Datum.count }
      end
    end
  end
end
