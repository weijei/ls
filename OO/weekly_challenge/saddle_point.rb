class Matrix
  def initialize(matrix)
    @matrix = matrix
  end

  def rows
     @matrix.split("\n").map{|row|row.split(' ').map(&:to_i)}
     #first split the string by "\n"
     #and iterante each row to split into items
     #tansform string to integer
  end

  def columns
    rows.transpose
  end

  def saddle_points
    result = []
    rows.each_with_index do |row_array, row_idx|
      #iterate each row with row_idx
      row_max = row_array.max
      #find the max value in iterated row
      row_array.each_with_index do |item, item_idx|
        #iterate each item in the row.
        column_min = columns[item_idx].min
        #the item idx in row will be it column idx. Find the min in corresponding column.
        result << [row_idx, item_idx] if item == column_min && item == row_max
        #check if the item is max in row and min in column. if so, add into array.
      end
    end
    result
  end
end

matrix = Matrix.new("18 3 39 19 91\n38 10 8 77 320\n3 4 8 6 7")
p matrix.rows[0]
p matrix.saddle_points
