class ArrayStuff
  def self.dedup(array)
    return array if array.length < 2
    uniques_array = []
    uniques_hash = {}
    (0...array.length).each do |index|
      if !uniques_hash[array[index]]
        uniques_hash[array[index]] = true
        uniques_array << array[index]
      end
    end
    uniques_array
  end
end

require "minitest/autorun"

class SomeThingTest < Minitest::Test
  def test_empty_array_returns_empty_array
    input = []
    assert_equal [], ArrayStuff.dedup(input)
  end

  def test_array_with_single_element_returns_array
    input = [1]
    assert_equal [1], ArrayStuff.dedup(input)
  end

  def test_array_with_duplicates_1
    input = [1, 2, 3, 4, 5, 6, 4, 6, 3, 3, 3, 7, 7, 7, 1, 2]
    assert_equal [1, 2, 3, 4, 5, 6, 7], ArrayStuff.dedup(input)
  end

  def test_all_duplicates_returns_array_with_single_value
    input = [42, 42, 42, 42, 42, 42, 42]
    assert_equal [42], ArrayStuff.dedup(input)
  end
end
