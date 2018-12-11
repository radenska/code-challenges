class ArrayStuff
  def self.dedup(array)
    return array if array.length < 2
    (0...array.length).each do |index|
      delete_at_index = []
      (0...array.length).each do |index_2|
        if index != index_2 && array[index] == array[index_2]
          delete_at_index << index_2
        end
      end
      if delete_at_index.length > 0
        array.delete_at(delete_at_index[0])
        if delete_at_index.length > 1
          incr = 1
          (1...delete_at_index.length).each do |n|
            delete_here = delete_at_index[n] - incr
            array.delete_at(delete_here)
            incr += 1
          end
        end
      end
    end
    array
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
    input = [1, 2, 3, 4, 5, 1, 2]
    assert_equal [1, 2, 3, 4, 5], ArrayStuff.dedup(input)
  end

  def test_array_with_duplicates_2
    input = [1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
    assert_equal [1, 2, 3, 4, 5], ArrayStuff.dedup(input)
  end

  def test_array_with_duplicates_3
    input = [1, 2, 3, 4, 5, 1, 2, 2]
    assert_equal [1, 2, 3, 4, 5], ArrayStuff.dedup(input)
  end

  def test_array_with_duplicates_3
    input = [1, 2, 3, 4, 5, 6, 4, 6, 3, 3, 3, 7, 7, 7, 1, 2]
    assert_equal [1, 2, 3, 4, 5, 6, 7], ArrayStuff.dedup(input)
  end

  def test_all_duplicates_returns_array_with_single_value
    input = [42, 42, 42, 42, 42, 42, 42]
    assert_equal [42], ArrayStuff.dedup(input)
  end
end
