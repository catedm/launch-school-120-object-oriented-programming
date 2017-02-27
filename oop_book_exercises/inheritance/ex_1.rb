class Vehicle

  attr_accessor :color, :year, :model

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @current_speed = 0
  end

  def speed_up(mph)
    @current_speed += mph
    puts "You push the gas and accelerate #{mph} mph."
  end

  def current_speed
    puts "You are currently going #{@current_speed} mph."
  end

  def brake(mph)
    @current_speed -= mph
    puts "You push the brake and decelerate #{mph} mph."
  end

  def turn_off
    @current_speed = 0
    puts "Let's park this bad boy."
  end

  def spray_paint(color)
    self.color = color
    puts "You just spray painted your car #{color}, and it looks awful."
  end

  def self.gas_milage(miles, gallons)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

class MyCar < Vehicle
  DOORS = 4

  def to_s
    "Nice car! It's a #{color}, #{year}, #{@model}!"
  end
end

class MyTruck < Vehicle
  DOORS = 2

  def to_s
    "Nice truck! It's a #{color}, #{year}, #{@model}!"
  end
end

billy = MyCar.new(2002, "red", "blazer")
puts billy
billy.speed_up(10)
james = MyTruck.new(2010, "black", "corvette")
puts james
