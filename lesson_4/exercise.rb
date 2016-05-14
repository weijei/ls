# def createPhoneNumber(numbers)
#   return "\(#{numbers[0..2].join}\) #{numbers[3..5].join}-#{numbers[6..9].join}"# end
# end

# numbers = [1,2,3,4,5,6,7,8,9,0]
# puts "\(#{numbers[0..2].join}\) #{numbers[3..5].join}-#{numbers[6..9].join}"
# def solution(number)
#   sum = 0
#   (1..number - 1).each do |v|
#     if v % 5 == 0 || v % 3 == 0
#       sum += v
#     end
#   end
#   sum
# end

# puts solution(20)
require "pry"

# # def colour_association(arr)
# #   new_arr = []
# #   arr.each do |v|
# #     hsh = {}
# #     hsh[v[0]] = v[1]
# #     new_arr << hsh
# #   end
# #   new_arr
# # end

# # puts colour_association([["white", "goodness"], ["blue", "tranquility"]])

# # def triple_trouble(one, two, three)
# #   length = one.length.to_i
# #   arr1 = one.split("")
# #   arr2 = two.split("")
# #   arr3 = three.split("")
# #   count = 0
# #   new_arr = []

# #   loop do
# #     new_arr << arr1[count]
# #     new_arr << arr2[count]
# #     new_arr << arr3[count]
# #     # binding.pry
# #     count += 1
# #     break if count == length
# #   end
# #   new_arr.join
# # end

# words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
#           'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
#           'flow', 'neon']
# result ={}

# words.each do |word|
#   key = word.split('').sort.join
#   if result.has_key?(key)
#     result[key].push(word)
#   else
#     result[key] = [word]
#   end
# end

# # words.each do |word|
#   key = word.split('').sort.join
#   if result.has_key?(key)
#     result[key].push(word)
#   else
#     result[key] = [word]
#   end
# end

# result.each do |k,v|
#   puts "--------"
#   puts v
# end

# result.each do |k, v|
#   puts "------"
#   p v
# end


# def insert_dash(num)
#   arr = num.to_s.split('')
#   new_arr = []
#   arr.each do |val|
#     new_arr.push val
#     if val.to_i.odd? and
#       new_arr.push('-')
#     end
#   end
#     if new_arr.last == "-"
#       new_arr.pop
#   new_arr.join
# end

# puts insert_dash(454793)

def squaresum(numbers)
  sum = 0
  numbers.each do |val|
    sum += val ** 2
  end
  sum
end

puts squaresum([1,3,6])