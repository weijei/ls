class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n,w,h)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says Arf!"
  end

  def change_info(n,h,w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end
  # def name
  #   @name
  # end

  # def name=(name)
  #   @name = name
  # end
end

sparky = GoodDog.new("Sparky", "12 inches", "10 lbs")

sparky.change_info("Spartacus","24 inches",'45 lbs')
puts sparky
# puts sparky.name
# puts sparky.height
# puts sparky.weight