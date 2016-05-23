require 'pry'

class Palindormes
  attr_accessor :num_array, :pair_array
  def initialize(max_factor: max_num, min_factor: min_num=1)
    @max_num = max_num
    @min_num = min_num
    @num_array = []
    @pair_array = []
  end

  def generate
    (@min_num..@max_num).each do |val_1|
      (@min_num..@max_num).each do |val_2|
        product_number = val_1 * val_2
        product_pair = [val_1,val_2]
        if palindorm?(val_1 * val_2)
          @num_array << product_number
          @pair_array << product_pair
        end
      end
    end
    @num_array
  end

  def smallest
    min_palindormes_num = num_array.min
    min_palindormes_pairs = pair_array.select do |value|
      min_palindormes_num == value[0] * value[1]
      end
    min_palindormes_pairs
    Factor.new(min_palindormes_num, min_palindormes_pairs)
  end

  def largest
    max_palindormes_num = num_array.max
    max_palindormes_pairs = @pair_array.select do |value_1, value_2|
      value_1 * value_2 == max_palindormes_num
    end
    Factor.new(max_palindormes_num,max_palindormes_pairs)
  end

  def palindorm?(num)
    num_array = num.to_s.split('')
    num_array == num_array.reverse
  end
end

class Factor
  attr_reader :value, :factors
  def initialize(value, factors)
    @value = value
    @factors = factors.first
  end
end



palindormes = Palindormes.new(max_factor: 9,min_factor: 1)
palindormes.generate
smallest = palindormes.smallest
largest = palindormes.largest
p smallest.value
p smallest.factors
p largest.value
p largest.factors