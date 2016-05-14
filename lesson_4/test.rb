# words = 'mountain atlas'

# def reverse_word(word)
#   arr = word.split("")
#   n = 0

#   new_arr = []
#   word_length = word.size

#   loop do
#     new_arr[n] = arr[word_length]
#     n += 1
#     word_length -= 1
#     break if word_length == -1
#   end

#   new_word = new_arr.join
# end

# puts reverse_word(words)

# def fizzbuzz(first_num,end_num)
# require 'pry'
# def fizzbuss(first_num,end_num)
#   unit_num = end_num - first_num + 1
#   arr = []

#   unit_num.times do
#     arr += [first_num]
#     first_num += 1
#   end
#   count = 0

#   arr.map! do |v|
#     if v % 15 == 0
#       v = 'fizzbuzz'
#     elsif v % 3 == 0
#       v = 'fizz'
#     elsif v % 5 == 0
#       v = 'buzz'
#     else
#       v = v
#     end
#   end
#   arr.join(", ")
# end

# puts fizzbuss(2,13)

# def remove_vow(words)
#   arr = words.split("")
#  new_arr =  arr.map do |val|
#               if val == "a" || val == "e" || val == "i" || val == "o" || val == "u"
#                 val = ""
#               else
#                 val
#               end
#             end
#   new_arr.join
# end

# puts remove_vow('mountain')

# def balance?(words)
#   arr = words.split("")
#   arr.count("(") == arr.count(")")
# end

# puts balance?("(workd))")

# #7
# a = "hello"
# b = "world"

# c = a
# d = b
# b = a
# a = c

# puts a && a.object_id
# puts b && b.object_id
# puts c && c.object_id
# puts d && d.object_id


  # arr = [1, 2, 3].select do |n|
  #   n + 2
  #   puts n
  # end

  # p arr

  # str = "hello"

  # def a_method
  #   puts str
  # end

  # a_method

  [1, 2, 3].map do |n|
    puts n.object_id
    n+1
    puts n.object_id
  end


  [1, 2, 3].map do |n|
    puts n.object_id
    n += 1
    puts n.object_id
  end