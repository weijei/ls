class Player
  attr_accessor :move, :name

  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end

  def set_name
    if human?
      n = ""
      loop do
        puts "Please input your name:"
        n = gets.chomp
        break unless n.empty?
        puts "You must input a value instead of empty."
      end
      self.name = n
    else
      self.name = ['R2D2','Hal','Chappie','Sonny','Number 5'].sample
    end
  end

  def choose
    if human?
      choice = nil
      loop do
        puts "Please choose rock, paper, or scissors:"
        choice = gets.chomp
        break if ['rock','paper','scissors'].include? choice
        puts "Sorry, invalid please do again"
      end
        self.move = choice
    else
      self.move = ['rock','paper','scissors'].sample
    end

  end

  def human?
    @player_type == :human
  end

end


class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock Paper Scissors!"
  end

  def display_goodbye_message
    puts "Thank you for playing! Goodbye!"
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again?(y/n)"
      answer = gets.chomp
      break if ['y','n'].include? answer.downcase
      puts "must be y or n."
    end

    return true if answer == 'y'
    return false
  end



  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."

    case human.move
    when 'rock'
      puts "It's a tie" if computer.move == 'rock'
      puts "#{human.name} won" if computer.move == 'scissors'
      puts "#{computer.name} won" if computer.move == 'paper'
    when 'paper'
      puts "It's a tie" if computer.move == 'paper'
      puts "#{human.name} won" if computer.move == 'rock'
      puts "#{computer.name} lose" if computer.move == 'scissors'
    when 'scissors'
      puts "It's a tie" if computer.move == 'scissors'
      puts "#{human.name} won" if computer.move == 'paper'
      puts "#{computer.name} lose" if computer.move == 'rock'
    end
  end
end

RPSGame.new.play
