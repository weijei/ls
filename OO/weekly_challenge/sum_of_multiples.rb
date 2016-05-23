
class SumOfMultiples
  def initialize(*multiples) # mutiple parameters
    @multiples = multiples
  end

  def to(limit)
    self.class.to(limit, @multiples)

  end

  def self.to(limit, multiples =[3, 5])
    arr = (0..limit -1).select do |number|
            multiples.any? {|multiples| number % multiples == 0}
          end
    arr.reduce(:+)
  end
end


p SumOfMultiples.to(1)
p SumOfMultiples.to(4)
p SumOfMultiples.to(10)
p SumOfMultiples.new(43, 47).to(10_000)