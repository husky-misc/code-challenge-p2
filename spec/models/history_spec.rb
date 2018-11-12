require 'rails_helper'

RSpec.describe History, type: :model do
  it { is_expected.to be_mongoid_document }
end
