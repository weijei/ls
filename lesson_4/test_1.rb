# def multiplication_table(r, c)
#   (1..r).map { |i|
#     (1..c).map { |j| i * j }
#   }
# end

# p multiplication_table(2,7)

# def to_currency(number)
#   number >= 1000 ? number.to_s.split("").insert(-4,",").join : number.to_s
# end

# p to_currency(12345567)

def fibonacci(number)
  if number < 2
    number
  else
    fibonacci(number - 1) + fibonacci(number - 2)
  end
end

puts fibonacci(6)