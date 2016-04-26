require 'pry'

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

def prompt(msg)
  puts("=> #{msg}")
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)

  puts "You are a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |     "
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |     "
  puts ""
end
# rubocop:enable Metrics/AbcSize
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(arr, delimiter=', ', word = 'or')
  arr[-1] = "#{word} #{arr[-1]}" if arr.size > 1
  arr.join(delimiter)
end



def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{empty_squares(brd).join(', ')}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt("Sorry! the input is not valid")
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = nil
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd)
    break if square
  end

  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    # if brd[line[0]] == PLAYER_MARKER &&
    #    brd[line[1]] == PLAYER_MARKER &&
    #    brd[line[2]] == PLAYER_MARKER
    #   return 'Player'
    # elsif brd[line[0]] == COMPUTER_MARKER &&
    #       brd[line[1]] == COMPUTER_MARKER &&
    #       brd[line[2]] == COMPUTER_MARKER
    #   return 'Computer'
    # end
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def play_again?
  prompt("Do you want to play again? (Y/N)")
  answer = gets.chomp
  answer.downcase.start_with?("y")
end

def find_at_risk_square(line, board)
  if board.values_at(*line).count(PLAYER_MARKER) == 2
    binding.pry
    board.select{|k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
    binding.pry
  else
    nil
  end
end

loop do
  player_win = 0
  computer_win = 0
  loop do

    board = initialize_board

    loop do
      system "clear"
      display_board(board)
      prompt "Player has won #{player_win} times and PC has won #{computer_win} times"
      player_places_piece!(board)
      if someone_won?(board)
        player_win += 1
        break
      elsif board_full?(board)
        break
      end

      computer_places_piece!(board)
      if someone_won?(board)
        computer_win += 1
        break
      elsif board_full?(board)
        break
      end
    end

    display_board(board)
    if someone_won?(board)
      prompt "#{detect_winner(board)} won the game!"
    else
      prompt "The squares are full. Game tied!"
    end
  break if player_win == 5 || computer_win == 5
  end
  break unless play_again?
end
prompt("See you next time! Bye Bye.")
