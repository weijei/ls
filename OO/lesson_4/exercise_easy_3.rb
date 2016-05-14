class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

hello = Hello.new
hello.hi

# # hello = Hello.new
# # hello.bye

# # hello = Hello.new
# # # hello.greet
# hello.greet("Goodbye")