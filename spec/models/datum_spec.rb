require 'rails_helper'

RSpec.describe Datum, type: :model do
  it { is_expected.to be_mongoid_document }

  it "is valid with valid attributes" do
    expect(Datum.new).to be_valid
  end

  it "can be created from a list" do
    expect do
      create_list(:datum, 2)
    end.to change { Datum.count }.by(2)
  end
end
