class Sieve
  def initialize(to_number)
     raise(ArgumentError, "There are no primes below 2!") if to_number < 2

    @to_number =  to_number
  end

  def primes
    (2..@to_number).select do |num|
      is_prime?(num)
    end
  end

  def is_prime?(number)
    # sqrt = Math.sqrt(number).to_i
    prime_array = (2..number-1).select do |num|
      number % num == 0
    end
    return true if prime_array.size < 1
  end
end

sieve = Sieve.new(1)
p sieve.primes