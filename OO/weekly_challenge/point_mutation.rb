# By counting the number of differences between two homologous DNA strands taken from different genomes with a common ancestor, we get a measure of the minimum number of point mutations that could have occurred on the evolutionary path between the two strands.

# This is called the 'Hamming distance'

#     GAGCCTACTAACGGGAT
#     CATCGTAATGACGGCCT
#     ^ ^ ^  ^ ^    ^^
# The Hamming distance between these two DNA strands is 7.

# The Hamming distance is only defined for sequences of equal length. Hence you may assume that only sequences of equal length will be passed to your hamming distance function.

class Dna
  def initialize(strand)
    @string = strand
  end

  def hamming_distance(distance)
    index = 0
    result = 0
    arr_strand = @string.chars
    arr_distance = distance.chars

    loop do
      if arr_strand[index] != arr_distance[index]
        result += 1
      end
      index += 1
      break if index == arr_strand.size || index == arr_distance.size
    end
    result
  end
end

p Dna.new('GACTACGGACAGGGTAGGGAAT').hamming_distance('GACATCGCACACC')

