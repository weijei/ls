class Anagram
  def initialize(word)
    @word = word
  end

  def match(comparison)
    sort_word = @word.downcase.chars.sort.join
    result = comparison.select do |word|
      word.downcase.chars.sort.join == sort_word &&
      word.downcase != @word
    end

  end
end

detector = Anagram.new('allergy')
p detector.match(%w(gallery ballerina regally clergy largely leading))
