# Write a program that will take a string of digits and give you all the possible
# consecutive number series of length n in that string.

# For example, the string "01234" has the following 3-digit series:

# - 012
# - 123
# - 234
# And the following 4-digit series:

# - 0123
# - 1234
# And if you ask for a 6-digit series from a 5-digit string, you deserve whatever you get.


class Series
  def initialize(series)
    @series = series
  end

  def slices(num)
    series_array = @series.chars.map(&:to_i)
    series_size = @series.length
    item_index = 0
    new_sliced_array = []
    starting_index = 0
    if num > series_size
      raise(ArgumentError, "Slice number CANNOT greater than series number")
    else
      loop do
        sliced_array_item = []
        item_index = starting_index
        loop do
          sliced_array_item << series_array[item_index]
          break if sliced_array_item.size == num
          item_index += 1
        end
        new_sliced_array << sliced_array_item
        starting_index +=1
        break if starting_index == series_size - num + 1
      end
    end
    new_sliced_array
  end
end

# series = Series.new('1234')
# p series.slice(1)

