require 'pry'
class Trinary
  def initialize(number)
    @number = number
  end

  def to_decimal
    sum = 0
    if invalid_number?(@number)
      sum = 0
    else
      @number.chars.reverse.each_with_index do |val, idx|
        sum += (val.to_i * (3 ** idx))
        end
    end
    sum
  end

  def invalid_number?(number)
    number =~ /[^0-2]/
    # '=~' match. [^0-2] means not 0-2 figure.
    # if number includes figure other then 0-2 will not return nil.
    # and invalid_number will return true.
  end
end

p Trinary.new('2').to_decimal
p Trinary.new('10').to_decimal
p Trinary.new('11').to_decimal
p Trinary.new('100').to_decimal
p Trinary.new('112').to_decimal
p Trinary.new('222').to_decimal
p Trinary.new('1122000120').to_decimal
p Trinary.new('carrot').to_decimal
p Trinary.new('0a1b2c').to_decimal


