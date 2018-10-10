class Item
  attr_reader :array, :circular_right_rotation, :index, :result

  def initialize(array:, circular_right_rotation:, index:)
    @array = array
    @circular_right_rotation = circular_right_rotation
    @index = index

    result!
  end

  private

  def result!
    array_with_right_rotation = @array.rotate(@circular_right_rotation * -1)
    @result = array_with_right_rotation.slice(@index)
  end
end