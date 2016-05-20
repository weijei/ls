VALID_CHOICES = %w(rock paper scissors Spock lizard).freeze
VALID_INPUT = %w(r p s S l).freeze
def prompt(message)
  puts("=> #{message}")
end

def win?(first, second)
  (first == 'rock' && (second == 'scissors' || second == 'lizard')) ||
    (first == 'paper' && (second == 'rock' ||second == 'Spock')) ||
    (first == 'scissors' && (second == 'paper' || second == 'lizard'))||
    (first == 'lizard' && (second == 'paper' || second == 'Spock'))||
    (first == 'Spock' && (second == 'rock' || second == 'scissors'))
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won")
  else
    prompt("Tied")
  end
end

loop do
  user_win = 0
  computer_win = 0
  loop do
    choice = ""
    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      prompt("Plese input first letter and s: scissors and S: Spock")
      choice = gets.chomp

      if VALID_INPUT.include?(choice)
        break
      else
        prompt("That's not a valid choice")
      end
    end

    case choice
    when "r"
      choice = "rock"
    when "s"
      choice = "scissors"
    when "S"
      choice = "Spock"
    when "p"
      choice = "paper"
    when "l"
      choice = "lizard"
    end

    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{choice} and Computer chose: #{computer_choice}")

    if win?(choice, computer_choice)
      user_win += 1
    elsif win?(computer_choice,choice)
      computer_win += 1
    end
    display_result(choice, computer_choice)
    prompt("You've won #{user_win} times and PC has won #{computer_win} times")
    prompt("------------------------------------------")
    if user_win == 5 || computer_win == 5
      break
    end
  end
  prompt("Do you want to play again? (Y/N)")
  answer = gets.chomp
  break unless answer.downcase.start_with?("y")
end

prompt("Thanks for playing! see you again")
