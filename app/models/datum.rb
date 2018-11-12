class Datum
  include Mongoid::Document
  field :content, type: Array
  field :rotations, type: Integer
  field :index, type: Integer

  validate :index_with_content_length
  validate :content_numbers
  validates :content, length: { maximum: 499 }
  validates :rotations, numericality: { less_than: 100000 }

  def index_with_content_length
    errors.add(:index, "can't be bigger than content length size") if index >= content.length
  end

  def content_numbers
    errors.add(:content, "can't have a number bigger than 500") if content.any?{ |n| n >= 500 }
  end
end
