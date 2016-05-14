
module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  attr_accessor :name, :model, :year
  def initialize(n, m, y)
    @name = n
    @model = m
    @year = y
    @current_speed = 0
  end

  def change_year(y)
    self.year = y
  end

  def speed_up(num)
    @current_speed += num
    puts "#{@name} - #{@model} speed up #{num} miles and current speed is #{@current_speed} miles"
  end

  def brake(num)
    @current_speed -= num
    puts "you slow down and current speed is #{@current_speed}"
  end

  def shut_down
    @current_speed = 0
    puts "you shut down and current speed is #{@current_speed}"
  end

  def self.gas_mileage(gallons,miles)
    puts "#{miles/gallons} miles per gallon of gas"
  end
  @@number_of_vehicles = 0

  def initiate
    @@number_of_vehicles += 1
  end

  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end

  def car_age
    puts "Your car is #{self.name} and is #{years_old} years old"
  end

  private

  def years_old
    Time.now.year - self.year.to_i
  end


end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2
end


mazda = MyTruck.new("VW","pickup","2008")
p mazda.can_tow?(1300)
mazda.speed_up(100)
mazda.brake(40)
mazda.shut_down
mazda.car_age
