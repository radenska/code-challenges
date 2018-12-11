class ArrayStuff
  def self.reverse(array)
    return array if array.length < 2
    index = array.length - 1
    halfway = array.length / 2
    (0...halfway).each do |first_position|
      second_position = array.length - 1 - first_position
      temp = array[first_position]
      array[first_position] = array[second_position]
      array[second_position] = temp
    end
    array
  end
end
require "minitest/autorun"

class SomeThingTest < Minitest::Test
  def test_reverse_array_odd_length
    input = [1, 2, 3, 4, 5]
    assert_equal [5, 4, 3, 2, 1], ArrayStuff.reverse(input)
  end
  
  def test_reverse_array_even_length
    input = [1, 2, 3, 4, 5, 6]
    assert_equal [6, 5, 4, 3, 2, 1], ArrayStuff.reverse(input)
  end

  def test_empty_array
    input = []
    assert_equal [], ArrayStuff.reverse(input)
  end

  def test_array_with_one_element
    input = [1]
    assert_equal [1], ArrayStuff.reverse(input)
  end
end
