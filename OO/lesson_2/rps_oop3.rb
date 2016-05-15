# frozen_string_literal: true
class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock'].freeze
  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def >(other_move)
    (rock? && other_move.lizard?) ||
      (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (paper? && other_move.spock?) ||
      (scissors? && other_move.paper?) ||
      (scissors? && other_move.lizard?) ||
      (lizard? && other_move.spock?) ||
      (lizard? && other_move.paper?) ||
      (spock? && other_move.rock?) ||
      (spock? && other_move.scissors?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score, :move_history

  def initialize
    set_name
    @score = 0
    @move_history = []
  end
end

class Human < Player
  def set_name
    player_name = ""
    loop do
      puts "=> Please input your name:"
      player_name = gets.chomp
      break unless player_name.empty?
      puts "You must input a value instead of empty."
    end
    self.name = player_name
  end

  def choose
    choice = nil
    loop do
      puts "=> Please choose #{Move::VALUES.join(', ')}:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include? choice
      puts "Sorry, invalid please do again"
    end
    self.move = Move.new(choice)
    move_history << move
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    mv = Move::VALUES.sample
    self.move = Move.new(mv)
    move_history << move
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    system 'clear'
    puts "#{human.name}! Welcome to Rock Paper Scissors Spock Lizard game!"
  end

  def display_goodbye_message
    puts "Thank you for playing! Goodbye!"
  end

  def play
    display_welcome_message
    loop do
      loop do
        display_record
        human.choose
        computer.choose
        display_move
        display_winner
        update_score
        break if human.score == 10 || computer.score == 10
      end
      display_final_winner
      display_moving_histroy
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

  def play_again?
    answer = nil
    loop do
      puts "=> Do you want to play again?(y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "must be y or n."
    end

    return false if answer.casecmp('n') == 0
    return true if answer.casecmp('y') == 0
  end

  def display_record
    puts ""
    puts "------------------"
    puts "#{human.name} has won #{human.score} times."
    puts "#{computer.name} has won #{computer.score} times."
    puts "------------------"
  end

  def display_move
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_final_winner
    display_record
    if human.score == 10
      puts "#{human.name} wins this series!"
    elsif computer.score == 10
      puts "#{computer.name} wins this series!"
    end
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} Won."
    elsif computer.move > human.move
      puts "#{computer.name} Won"
    else
      puts "It's tie."
    end
  end

  def update_score
    if human.move > computer.move
      human.score += 1
    elsif computer.move > human.move
      computer.score +=1
    end
  end

  def display_moving_histroy
    history = human.move_history.zip(computer.move_history)
    puts "#{human.name}'s battle history:"
    puts "------------------------------------------------"
    puts "Round        \t\ #{human.name.ljust(10, ' ')} \t\  \t\ #{computer.name.ljust(10, ' ')} \t\     "
    history.each do |h_mv, c_mv|
      puts "#{human.move_history.index(h_mv).to_s.ljust(2, ' ')}        \t\ #{h_mv.to_s.ljust(7, ' ')} \t\  \t\ #{c_mv.to_s.ljust(7, ' ')} \t\ "
    end
  end

  def reset
    human.score = 0
    computer.score = 0
    human.move_history = []
    computer.move_history = []
  end
end

RPSGame.new.play
