class Datum
  include Mongoid::Document
  field :content, type: Array
  field :rotations, type: Integer
  field :index, type: Integer

  validate :index_with_content_length,

  def index_with_content_length
    if index >= content.length
      errors.add(:index, "can't be bigger than content length size")
    end
  end
end
