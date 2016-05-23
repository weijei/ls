require 'pry'
class Clock
  attr_accessor :clock, :minute
  def initialize(clock, minute)
    @clock = clock
    @minute = minute
  end

  def self.at(clock, minute=0)
    new(clock, minute)
  end

  def to_s
    if @clock > 9 && @minute > 9
      "#{@clock}:#{@minute}"
    elsif @clock > 9 && @minute < 10
      "#{@clock}:0#{@minute}"
    elsif @clock < 10 && @minute > 9
      "0#{@clock}:#{@minute}"
    else
      "0#{@clock}:0#{@minute}"
    end
  end

  def +(num)
    @clock = (@clock + ((@minute + num) / 60).to_i) % 24
    @minute = (@minute + num) % 60
    self #call self as we are doing to_s for the class object
  end

  def -(num)
    minutes_to_reduce = num % 60
    clock_to_reduce = (num / 60).to_i % 24
    if minutes_to_reduce > @minute
      @minute = @minute + 60 - minutes_to_reduce
      @clock -= (clock_to_reduce+1)
    else
      @minute -= minutes_to_reduce
      @clock -= clock_to_reduce
    end
    if @clock < 0
      @clock += 24
    end
    self
  end


  def ==(other)
    @clock == other.clock && @minute == other.minute
  end

end
clock1 = Clock.at(23, 30) - 60

p clock1.to_s
