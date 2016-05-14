require 'pry'

SUITS = ['S', 'D', 'H', 'C'].freeze
CARDS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'A', 'J', 'Q', 'K'].freeze

def prompt(message)
  puts("=> #{message}")
end

def calculate_total(cards)
  arr = cards.map { |card| card[1] }
  total = 0
  arr.each do |num|
    if num == 'A'
      total += 11
    elsif num == 'K' || num == 'J' || num == 'Q'
      total += 10
    else total += num.to_i
    end
  end

  arr.select { |num| num == 'A' }.count.times do
    total -= 10 if total > 21
  end
  total
end

def initialize_card
  deck = SUITS.product(CARDS)
  deck.shuffle!
  deck
end

def busted?(cards)
  calculate_total(cards) > 21
end

def enough?(cards)
  calculate_total(cards) < 17
end

def who_win?(player, dealer)
  if calculate_total(player) > calculate_total(dealer)
    "You Win"
  elsif calculate_total(player) < calculate_total(dealer)
    "Dealer Win"
  else "It's a tie"
  end
end

def play_again?
  answer = []
  loop do
    puts "-------------"
    prompt "Do you want to play again? (y or n)"
    answer = gets.chomp
    prompt "your input is invalid" if !answer.downcase.start_with?('y', 'n')
    break if answer.downcase.start_with?('y', 'n')
  end
  answer.downcase.start_with?('y')
end

loop do
  prompt "Welcome to the Game!"
  deck = []
  mycard = []
  dealercard = []

  deck = initialize_card
  2.times do
    mycard << deck.pop
    dealercard << deck.pop
  end

  prompt "Dealers first card is hidden and 2nd card is #{dealercard[1].join}"
  prompt "Your two cards are #{mycard[0].join} and #{mycard[1].join}. Total score is #{calculate_total(mycard)}"

  answer = nil

  loop do
    prompt "Hit or Stay? (h for hit and s for stay)"
    answer = gets.chomp

    if answer.downcase.start_with?('h')
      mycard << deck.pop
      prompt "you have card: #{mycard} and total is #{calculate_total(mycard)}"
    end

    if !answer.downcase.start_with?('s', 'h')
      prompt "Your input is invalid"
    end
    break if answer.downcase.start_with?('s') || busted?(mycard)
  end

  if busted?(mycard)
    prompt('You Busted!! Dealer Win!!')
    play_again? ? next : break
  else
    prompt("You choose to stay! now it's Dealer's turn")
  end

  loop do
    if enough?(dealercard)
      prompt 'Dealer decide to hit'
      dealercard << deck.pop
    end
    break if !enough?(dealercard) || busted?(dealercard)
  end
  if busted?(dealercard)
    prompt('Dealer Busted! You win!!')
    play_again? ? next : break
  else
    prompt "Dealer choose to stay!! Let's see both cards."
    prompt "Dealer's cards are #{dealercard} and score is #{calculate_total(dealercard)}"
    prompt "Your cards are #{mycard} and score is #{calculate_total(mycard)}"
    prompt who_win?(mycard, dealercard)
  end

  play_again? ? next : break
end

prompt "Thanks for your playing! See you next time!"
