class Board   #represent a snapshot of board
  WINNING_LINES = [[1, 2, 3],[4, 5, 6],[7, 8, 9]] +
                  [[1, 4, 7],[2, 5, 8],[3, 6, 9]] +
                  [[1, 5, 9],[3, 5, 7]]
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select {|key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def reset
    (1..9).each {|key| @squares[key] = Square.new(key.to_s)}
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def two_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    empty_square = squares.select(&:unmarked?)
    if markers.size == 2 && squares.select(&:marked?) == 2
      return true
    end
  end

  def strategic_marker
    strategic_squares =[]
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers?(square)
        return squares.first.marker
      end
    end
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)      # => we wish this method existed
        return squares.first.marker             # => return the marker, whatever it is
      end
    end
    nil
  end

  def joinor(array, delimiter=', ', word='or')
    array[-1] = "#{word} #{array.last}" if array.size > 1
    array.join(delimiter)
  end

end

class Square
  attr_accessor :marker

  def marked?
    !(1..9).map{ |num|num.to_s }.include? marker
  end

  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    (1..9).map{ |num|num.to_s }.include? marker
  end
end

class Player
  attr_accessor :marker
  attr_accessor :win_times

  def initialize
    @marker
    @win_times = 0
  end

end


class TTTGame
  attr_reader :board, :human, :computer


  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Player.new
    @current_marker
  end

  def play
    display_welcome_message
    loop do
      pick_marker
      loop do
        display_board
        loop do
          human_moves
          break if board.someone_won? || board.full?

          computer_moves
          break if board.someone_won? || board.full?

          clear_screen_and_display_board
        end
        display_result
        reset
        break if someone_won_five_times?
      end
      display_winning_message
      break unless play_again?
        new_game
        display_play_again_message
    end
    display_goodbye_message
  end

  private

  def display_welcome_message
    clear
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def pick_marker
    puts "Please your marker: 'X' or 'O':"
    chosen_marker = ""
    loop do
      chosen_marker = gets.chomp
      break if %w(X O).include? chosen_marker
      puts "Sorry! Must be X or O"
    end
    human.marker = chosen_marker
    computer.marker = 'XO'.delete(chosen_marker)
    @current_marker = human.marker
  end


  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
    puts "You've won #{human.win_times} and Computer has won #{computer.win_times}"
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Choose a square: #{board.unmarked_keys.join(", ")}:"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "sorry. not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
  if board.threat_marker == computer.marker
    board[square]
    then attach
  else
    board[board.unmarked_keys.sample] = computer.marker
  end

  # def human_turn?
  #   @current_marker == HUMAN_MARKER
  # end

  def current_player_moves
    if @current_marker == human.marker
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end


  def display_result
    display_board

    case board.winning_marker
    when human.marker
      human.win_times += 1
      puts "You Won!"
    when computer.marker
      computer.win_times += 1
      puts "Computer won!"
    else
      puts "The board is full!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?(y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry! Must be y or n"
    end
    answer == 'y'
  end

  def clear
    system "clear"
  end

  def reset
    board.reset
    clear
  end

  def new_game
    board.reset
    human.win_times = 0
    computer.win_times = 0
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def someone_won_five_times?
    human.win_times == 5 || computer.win_times == 5
  end

  def display_winning_message
    if human.win_times == 5
      puts "You've won five times! You won!"
    else
      puts "Computer won five times! You lose!"
    end
  end

end

game = TTTGame.new
game.play

