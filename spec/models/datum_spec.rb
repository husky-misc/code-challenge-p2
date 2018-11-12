require 'rails_helper'

RSpec.describe Datum, type: :model do
  it { is_expected.to be_mongoid_document }

  describe ".create" do
    context "when index is bigger than content length size" do
      it "does not save the invalid records" do
        expect do
          Datum.create([{content: [1,2, 4,5,6,7], index: 5}, {content: [1], index: 11}])
        end.not_to change { Datum.count }
      end
    end
  end

end
