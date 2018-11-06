class Datum
  include Mongoid::Document
  field :content, type: Array
  field :rotations, type: Integer
  field :index, type: Integer
end
