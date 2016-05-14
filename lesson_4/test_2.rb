def remove_vowel(arr)
  arr.map do |word|
    word.delete('aeiouAEIOU')
  end
end

puts remove_vowel(["dog", "cat", "monkey"])

def is_balance?(str)
  str.count('(') == str.count(')')
end

puts is_balance?('((kand)kjs)')

def find_prime(num1,num2)
  (num1..num2).select do |num|
    is_prime?(num)
  end
end

def is_prime?(num)
  (2..num-1).each do |val|
    if num % val == 0
      return false
    end
  end
end

p find_prime(100,120)

def string_reverse(str)
  arr = str.split(' ')
  new_arr = []
  len = arr.length
  arr.each do |word|
    new_arr[len-1] = word
    len -=1
  # loop do
  #   new_arr << arr[len-1]
  #   len -= 1
  # break if len == 0
  end
  new_arr.join(" ")
end

p string_reverse("I am a super star monkey keystone")
p string_reverse("I am a super star monkey keystone").delete(' ')
def fizzbuzz(num1,num2)
  (num1..num2).map do |num|
    if num % 15 == 0
      num = "fizzbuzz"
    elsif num % 5 == 0
      num = "buzz"
    elsif num % 3 == 0
      num = "fizz"
    else
      num = num
    end
  end
end

p fizzbuzz(2,21)

puts find_prime(123,456)
require 'pry'

PRODUCTS = [
{name: "Thinkpad X210", price: 220},
{name: "Thinkpad X220", price: 250},
{name: "Thinkpad X250", price: 979},
{name: "Thinkpad X230", price: 380},
{name: "Thinkpad X230", price: 330},
{name: "Thinkpad X230", price: 350},
{name: "Thinkpad X240", price: 700},
{name: "Macbook Leopard", price: 300},
{name: "Macbook Air", price: 700},
{name: "Macbook Pro", price: 680},
{name: "Macbook", price: 1440},
{name: "Dell Latitue", price: 280},
{name: "Dell Latitue", price: 650},
{name: "Dell Inspiron", price: 300},
{name: "Dell Inspiron", price: 450},
]

query = {
price_min: 240,
price_max: 280,
q: 'Thinkpad'
}

query2 = {
  price_min: 300,
  price_max: 450,
  q: 'Dell'
}

def search(query)
  PRODUCTS.select do |hsh|
    hsh[:name].include?(query[:q]) &&
    hsh[:price] >= query[:price_min] &&
    hsh[:price] <= query[:price_max]
   # binding.pry
  end
end

p search(query2)

def find_even_index(arr)
  len = arr.length
  index = -1
  arr.each_index do |idx|
    left_sum = arr[0..idx].inject(:+)
    right_sum = arr[idx..len].inject(:+)
    if left_sum == right_sum
       index = idx
       break
    end
  end
  index
end

def find_even_index(array)
  array_size = array.length
  result = -1
  array.each_with_index do |a, index|
    left_side = array[0..index]
    right_side = array[index..array_size]
    if left_side.inject(:+) == right_side.inject(:+)
      result = index
      break
    end
  end
  result
end
