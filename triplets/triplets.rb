require 'benchmark'

class Triplets
  def self.find(array)
    results = nil
    (0...array.length - 1).each do |index|
      (index + 1...array.length).each do |second|
        sum = -(array[index] + array[second])
        if array.include?(sum) && array[index] != sum && array[second] != sum
          results = [sum, array[index], array[second]]
        end
        break if results
      end
      break if results
    end
    results
  end
end

array = []
10_000.times do
  random = (rand() * 100).to_i
  pos_or_neg = (rand() * 100).to_i
  random = -random if pos_or_neg.even?
  if !array.include?(random)
    array << random
  end
end
puts Benchmark.measure {
  100_000.times do
    Triplets.find(array)
  end
}
