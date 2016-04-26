require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts("=> #{message}")
end

def valid_number?(num)
  num.to_i != 0
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

def number?(input)
  integer?(input) || float?(input)
end

def operator_to_message(op)
  word = case op
           when '1'
             'Adding'
           when '2'
             'Substracting'
           when '3'
             'Mutiplying'
           when '4'
             'Dividing'
         end
  x = "awesome"

  word
end

prompt(MESSAGES['cht']['welcome'])

name = ''
loop do
  name = gets().chomp()

  if name.empty?()
    prompt(MESSAGES['en']['valid_name'])
  else
    break
  end
end

prompt("Hi #{name}!")

loop do
  number1 = ''
  loop do
    prompt(MESSAGES['en']['first_number'])
    number1 = gets().chomp()
    if number?(number1)
      break
    else
      prompt("Your input #{number1} is not valid number, please input again")
    end
  end

  number2 = ''
  loop do
    prompt("What's the second number?")
    number2 = gets().chomp()
    if number?(number2)
      break
    else
      prompt("Your input #{number2} is not valid number, please input again")
    end
  end

  operation_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) substract
    3) multiply
    4) divide

  MSG

  prompt(operation_prompt)
  operator = ''

  loop do
    operator = gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Must choose 1, 2, 3 or 4")
    end
  end

  prompt("#{operator_to_message(operator)} the two numbers ...")

  result = case operator
           when '1'
             number1.to_i + number2.to_i
           when '2'
             number1.to_i - number2.to_i
           when '3'
             number1.to_i * number2.to_i
           when '4'
             number1.to_f / number2.to_f
  end

  prompt("The result is #{result}")
  prompt("Do you want to do perform another calculation?(Y to calculate again)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for using the Calculator")
