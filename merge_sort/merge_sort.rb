class Sort
  def self.ms(array)
    return array if array.length < 2
    merge(ms(array.slice(0, array.length / 2)), ms(array.slice(array.length / 2, array.length)))
  end

  def self.merge(first_array, second_array)
    return second_array if first_array.nil?
    return first_array if second_array.nil?

    first_pointer = 0
    second_pointer = 0
    merged = []
    loop do
      if first_array[first_pointer] <= second_array[second_pointer]
        merged << first_array[first_pointer]
        first_pointer += 1
      else
        merged << second_array[second_pointer]
        second_pointer += 1
      end
      if first_pointer == first_array.length
        merged.push(*remaining(second_array, second_pointer))
        break
      end
      if second_pointer == second_array.length
        merged.push(*remaining(first_array, first_pointer))
        break
      end
    end
    merged
  end

  def self.remaining(array, pointer)
    array[pointer..array.length]
  end
end

require "minitest/autorun"

class SortTest < Minitest::Test
  def test_sort_empty_array
    assert_equal [], Sort.ms([])
  end

  def test_sort_array_with_single_element
    assert_equal [42], Sort.ms([42])
  end

  def test_sort_small_array
    assert_equal [1, 2, 3, 4, 6, 6], Sort.ms([4, 2, 6, 1, 6, 3])
  end

  def test_sort_reversed_small_array
    assert_equal [1, 2, 3, 4, 5], Sort.ms([5, 4, 3, 2, 1])
  end

  def test_sort_already_sorted_small_array
    assert_equal [1, 2, 3, 4, 5], Sort.ms([1, 2, 3, 4, 5])
  end

  def test_array_of_multiple_value
    assert_equal [42, 42, 42, 42, 42, 42, 42], Sort.ms([42, 42, 42, 42, 42, 42, 42])
  end
end
