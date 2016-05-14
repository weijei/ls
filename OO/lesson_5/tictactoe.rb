require "pry"

class Board   #represent a snapshot of board
  WINNING_LINES = [[1, 2, 3],[4, 5, 6],[7, 8, 9]] +
                  [[1, 4, 7],[2, 5, 8],[3, 6, 9]] +
                  [[1, 5, 9],[3, 5, 7]]
  def draw
    puts "     |     |"
    puts "  #{get_square_at(1)}  |  #{get_square_at(2)}  |  #{get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{get_square_at(4)}  |  #{get_square_at(5)}  |  #{get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{get_square_at(7)}  |  #{get_square_at(8)}  |  #{get_square_at(9)}"
    puts "     |     |"
  end

  def initialize
    @squares = {}
    reset
  end

  def get_square_at(key)
    @squares[key]
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

  #return winning marker or nil
  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
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

  def reset
    (1..9).each {|key| @squares[key] = Square.new(key.to_s)}
  end

end

class Square
  attr_accessor :marker
  INITIAL_MARKER = " "

  def marked?
    marker == TTTGame::HUMAN_MARKER || marker == TTTGame::COMPUTER_MARKER
  end

  def initialize(marker=INITIAL_MARKER)
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
  attr_reader :marker
  attr_accessor :win_times

  def initialize(marker)
    @marker = marker
    @win_times = 0
  end

end


class TTTGame
  attr_reader :board, :human, :computer
  HUMAN_MARKER = "X"
  human_marker_test = "K"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = HUMAN_MARKER

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Player.new
    @current_marker = FIRST_TO_MOVE
  end

  def play
    display_welcome_message
    # pick_marker
    loop do
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

  # def pick_marker
  #   puts "Please your marker: 'X' or 'O':"
  #   loop do
  #     chosen_marker = gets.chomp
  #     break if %w(X O).include? chosen_marker
  #     puts "Sorry! Must be X or O"
  #   end
  #   HUMAN_MARKER = chosen_marker
  #   COMPUTER_MARKER = 'XO'.delete(chosen_marker)
  # end


  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're a #{HUMAN_MARKER}. Computer is a #{COMPUTER_MARKER}"
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
    board[board.unmarked_keys.sample] = computer.marker
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker == COMPUTER_MARKER
    else
      computer_moves
      @current_marker == HUMAN_MARKER
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
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def new_game
    board.reset
    @current_marker = FIRST_TO_MOVE
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

