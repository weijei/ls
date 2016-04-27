

def calculate_total(cards)
  arr = cards.map { |card| card[1]}
  total = 0
  arr.each do |num|
    if num == 'A'
      total += 11
    elsif num == 'K' || num == 'J' || num == 'Q'
      total += 10
    else total += num.to_i
    end
  end

  arr.select{|num| num == 'A'}.count.times do
    total -= 10 if total > 21
  end
  return total
end

arr = [["C", "7"], ["C", "3"], ["S", "5"], ["S", "10"], ["D", "3"]]

def busted?(cards)
  calculate_total(cards) > 21
end

p busted?(arr)
