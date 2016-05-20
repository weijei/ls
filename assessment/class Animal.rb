module Fast
  def fast
    “I run very fast!”
  end
end

module Wheels
  def wheels
    “I have wheels”
  end
end

class Vehicle
  include Wheels
  def drive
    "I could move!"
  end
end

class Bus < Vehicle
  def drive
    "I could drive a lots of people home!"
  end
end

class Car < Vehicle
  include Fast
end

car = Car.new
puts Car.ancestors

# Car
# Fast
# Vehicle
# Wheels
# Object
# Kernel
# BasicObject


arr = ['John','Bob','Tony','Duncan']
arr.map{|val| val + "!"}