require 'pry'

class Prime
  def initialize(num)
    @num = num
  end

  def self.is_prime?(number)
    return false if number == 1
    !(2..Math.sqrt(number).to_i).map {|val| number % val == 0}.include? true
  end

  def self.nth(upperlimit)
    prime = 2 # 1 is not prime and no need to start with 1
    arr = []
    loop do
      break if arr.length == upperlimit
      # binding.pry
      if is_prime?(prime)
        arr << prime
      end
      prime += 1
    end
    # puts arr
    arr.last
  end
end

p Prime.nth(10001)