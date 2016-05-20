class Move
  attr_reader :value, :beats
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock'].freeze
  def initialize(value)
    @value = value
    @beats = []
  end

  def beats?(opponent)
    opponent = opponent.value
    beats.include? opponent
  end
end

class Rock < Move
  def initialize(value)
    super
    @beats = ['scissors', 'lizard']
  end
end

class Paper < Move
  def initialize(value)
    super
    @beats = ['rock', 'spock']
  end
end

class Scissors < Move
  def initialize(value)
    super
    @beats = ['paper', 'lizard']
  end
end

class Lizard < Move
  def initialize(value)
    super
    @beats = ['spock', 'paper']
  end
end

class Spock < Move
  def initialize(value)
    super
    @beats = ['scissors', 'rock']
  end
end

class History
  attr_accessor :moves
  def initialize
    @moves = []
  end

  def update(move1, move2)
    if move1.beats? move2
      add_win_for move1.value
    elsif move2.beats? move1
      add_loss_for move1.value
    else
      add_tie_for move1.value
    end
  end

  def add_win_for(move)
    moves << { move => 'win' }
  end

  def add_loss_for(move)
    moves << { move => 'lose' }
  end

  def add_tie_for(move)
    moves << { move => 'tie' }
  end
end

class Player
  attr_accessor :move, :name, :score, :history
  def initialize
    set_name
    @score = 0
    @history = History.new
  end

  def pick_move(choice)
    self.move = case choice
                when 'rock' then Rock.new(choice)
                when 'paper' then Paper.new(choice)
                when 'scissors' then Scissors.new(choice)
                when 'lizard' then Lizard.new(choice)
                when 'spock' then Spock.new(choice)
                end
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp.capitalize
      break unless n.empty?
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors, lizard, or spock"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    pick_move choice
  end
end

# preferences is a hash of move values for keys and an integer weighted value.
class Computer < Player
  attr_reader :preferences
  def initialize
    super
    @preferences = {}
  end

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    sum = preferences.inject(0) do |total, item_and_weight|
      total + item_and_weight[1]
    end
    target = rand(sum)
    preferences.each do |item, weight|
      return pick_move(item) if target <= weight
      target -= weight
    end
  end
end

class R2D2 < Computer
  def initialize
    super
    @name = 'R2D2'
    @preferences = { 'rock' => 80, 'spock' => 10, 'lizard' => 10 }
  end
end

class Hal < Computer
  def initialize
    super
    @name = 'Hal'
    @preferences = { 'spock' => 50, 'scissors' => 25, 'paper' => 25 }
  end
end

class Chappie < Computer
  def initialize
    super
    @name = 'Chappie'
    @preferences = { 'rock' => 20, 'paper' => 20,
                     'scissors' => 20, 'lizard' => 20,
                     'spock' => 20 }
  end
end

class Sonny < Computer
  def initialize
    super
    @name = 'Sonny'
    @preferences = { 'paper' => 60, 'lizard' => 20, 'scissors' => 20 }
  end
end

class Number5 < Computer
  def initialize
    super
    @name = 'Number 5'
    @preferences = { 'spock' => 60, 'rock' => 20, 'scissors' => 20 }
  end
end

class RPSGame
  MAX_SCORE = 10
  OPPONENTS = { 1 => 'R2D2', 2 => 'Hal', 3 => 'Chappie',
                4 => 'Sonny', 5 => 'Number 5' }.freeze
  attr_accessor :human, :computer
  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock #{human.name}!"
  end

  def display_opponents
    puts "Who would you like to compete against? (1-5)"
    choices = <<-CHOICES
      1. R2D2
      2. Hal
      3. Chappie
      4. Sonny
      5. Number 5
    CHOICES
    puts choices
  end

  def select_opponent
    display_opponents
    answer = nil
    loop do
      answer = gets.chomp.to_i
      break if RPSGame::OPPONENTS.key? answer
      puts "Please choose (1-5)"
    end
    answer = RPSGame::OPPONENTS[answer]
    opponent_for(answer)
  end

  def opponent_for(selection)
    case selection
    when 'R2D2' then self.computer = R2D2.new
    when 'Hal' then self.computer = Hal.new
    when 'Chappie' then self.computer = Chappie.new
    when 'Sonny' then self.computer = Sonny.new
    when 'Number 5' then self.computer = Number5.new
    end
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock #{human.name}! Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move.value}."
    puts "#{computer.name} chose #{computer.move.value}."
  end

  def human_won?
    if human.move.beats? computer.move
      human.score += 1
      return true
    end
  end

  def computer_won?
    if computer.move.beats? human.move
      computer.score += 1
      return true
    end
  end

  def update_player_history(human, computer)
    human.history.update(human.move, computer.move)
    computer.history.update(computer.move, human.move)
  end

  def display_winner
    if human_won?
      puts "#{human.name} won!"
    elsif computer_won?
      puts "#{computer.name} won!"
    else
      puts "It's a Tie!"
    end
  end

  def display_scores
    puts "#{human.name}'s score is #{human.score}"
    puts "#{computer.name}'s score is #{computer.score}"
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end

  def game_over?
    if human.score == RPSGame::MAX_SCORE ||
       computer.score == RPSGame::MAX_SCORE
      puts "Game Over!"
      return true
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def play_round
    human.choose
    computer.choose
    display_moves
    display_winner
    display_scores
    update_player_history(human, computer)
  end

  def play_game
    display_welcome_message
    select_opponent
    loop do
      play_round
      if game_over?
        play_again? ? reset_scores : break
      end
    end
    display_goodbye_message
  end
end

RPSGame.new.play_game