# Pascal's Triangle

# Write a program that computes Pascal's triangle up to a given number of rows.

# In Pascal's Triangle each number is computed by adding the numbers to the right and left of the current position in the previous row.

#     1
#    1 1
#   1 2 1
#  1 3 3 1
# 1 4 6 4 1
# # ... etc

class Triangle
  def initialize(rows)
    @rows = rows
    @triangle = []

  end

  def create_rows
    @triangle = [[1]]
    (2..@rows).each do |row_idx|
      @triangle << triangle_row(row_idx)
    end
    @triangle
  end

  def triangle_row(row_idx)
    arr = []
    row_idx.times do |num|
      if num == 0 || num == row_idx - 1
        arr << 1
      else
        arr << @triangle[row_idx - 2][num - 1] + @triangle[row_idx - 2][num]
      end
    end
    arr
  end
end

triangle = Triangle.new(10)
p triangle.create_rows
