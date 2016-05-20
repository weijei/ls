# def select(arr)
#   counter = 0
#   new_arr =[]
#   while counter < arr.size
#     if yield(arr[counter])
#       new_arr << arr[counter]
#     end
#     counter += 1
#   end

#   new_arr
# end

# array = [1, 2, 3, 4, 5]
# p select(array) { |num| num.odd? }
# p select(array) { |num| puts num }
# p select(array) { |num| num + 1 }

def map(arr)
  new_arr = []
  counter = 0
  size = arr.size
  while counter < size
   new_arr << yield(arr[counter])
   counter += 1
  end
  new_arr
end

arr = [1,2,3]
p arr.map{|num|num+1}
