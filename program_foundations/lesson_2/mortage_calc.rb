
def prompt(word)
  puts("=> #{word}")
end


prompt("Welcome to mortage calculator! ")
prompt("-------------------------------")

prompt("Hi! Please enter your loan amount:")
loan = ""

loop do
  loan = gets.chomp
  if loan.empty? || loan.to_f < 0
    prompt("Your loan input is not valid")
  else
    break
  end
end


prompt("Please enter your Annual Percentage Rate(APR) in %: ")
prompt("eg: APR is 16%, please input 16")
apr=""
loop do
  apr = gets.chomp
  if apr.empty? || apr.to_f <0
    prompt("Your input must be greater than zero")
  else
    break
  end
end


prompt("Pleaer enter your loan duration in years:")
loan_duration_year = ""

loop do
  loan_duration_year = gets.chomp
  if loan_duration_year.empty? || loan_duration_year.to_f < 0
    prompt("Your input is not valid. It must be positive")
  else
    break
  end
end

monthly_rate = apr.to_f / 12 / 100
months = loan_duration_year.to_i * 12

monthly_payment = loan.to_f *
                  (monthly_rate /
                  (1 -(1 + monthly_rate) ** -months))

puts("Your monthly payment is  #{monthly_payment} ")

