require 'pry'

class CrptoTest
  attr_accessor :string

  def initialize(string)
    @string = string
  end

  def normalized_string
    @string.downcase.gsub(/\W/, '')
  end

  def square_size
    size = normalized_string.chars.size
    n = 0
    loop do
      n += 1
      break if n * n > size
    end
    n
  end

  def to_array
    normalized_string.scan(/.{1,#{square_size}}/)
  end

  def array_to_sqaure
    new_arr = to_array.map { |row| row.split('') }
    loop do
      new_arr.last.push("")
      break if new_arr.last.size == square_size
    end
    new_arr
  end

  def cypto_text
    array_to_sqaure.transpose.join
  end


end

string_1 = CrptoTest.new("i'm a good student.")
p string_1.cypto_text



