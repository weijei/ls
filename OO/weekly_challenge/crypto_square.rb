class Crypto
  attr_accessor :string

  def initialize(string)
    @string = string
  end

  def normalize_plaintext
    @string.gsub(/[\W]/, '').downcase
  end

  def size
    string_size = normalize_plaintext.chars.size
    square_size = 0
    loop do
      square_size += 1
      break if square_size * square_size >= string_size
    end
    square_size
  end

  def plaintext_segments
    normalize_plaintext.scan(/.{1,#{size}}/)
  end

  def array_to_sqaure
    new_arr = plaintext_segments.map { |row| row.split('') }
    loop do
      break if new_arr.last.size == size
      new_arr.last.push("")
    end
    new_arr
  end

  def ciphertext
    array_to_sqaure.transpose
  end

  def normalize_ciphertext
    ciphertext.map { |value| value.join("") }.join(" ")
  end

end

string_1 = Crypto.new("If man was meant to stay on the ground god would have given us roots")
p string_1.normalize_ciphertext



