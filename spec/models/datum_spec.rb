require 'rails_helper'

RSpec.describe Datum, type: :model do
  it { is_expected.to be_mongoid_document }

  it "is valid with valid attributes" do
    expect(Datum.new).to be_valid
  end

  it "can be created from a list" do
    expect do
      Datum.create([
        {:content=> [1,2], :index => 2, :rotations => 1}, 
        {:content=> [3,4], :index => 1, :rotations => 2},
      ])
    end.to change { Datum.count }.by(2)
  end
end
