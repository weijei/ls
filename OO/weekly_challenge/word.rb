class WordProblem
    OPERATORS = {
      "plus" => '+',
      "minus" => '-',
      "divided by" => '/',
      "multiplied by" => '*'
    }

  def initialize(phrase)
    # @operands = phrase.scan(/\d+/).map(&:to_i)
    @operators = phrase.scan(/plus|minus|divided\ by|multiplied\ by/)
    @operands = phrase.split(' ').keep_if{|word|word.match(/\d+/)}.map{|word|word.chomp("?")}
                .map{|word| word.to_i}
    fail ArgumentError unless @operators.size > 0 || @operands.size > 1
  end

  def answer
    index = 1
    result = @operands[0]
    while index < @operands.size
      result = result.send(OPERATORS[@operators[index-1]], @operands[index])
      index += 1
    end
    result
  end
end

# WordProblem.new('What is 1 plus 1?').answer