module Convertable
  def is_convertable?
    puts "WOW. Convertables are nice. You must be rich!"
  end
end

class Vehicle

  attr_accessor :color, :year, :model

  @@number_of_vehicles = 0

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def self.number_of_vehicles
    puts "There are #{@@number_of_vehicles} vehicles"
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
  include Convertable
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
puts ''
puts "Vehicle method lookup chain"
puts "------------------------"
puts Vehicle.ancestors
puts ""
puts "MyCar method lookup chain"
puts "------------------------"
puts MyCar.ancestors
puts ""
puts "MyTruck method lookup chain"
puts "------------------------"
puts MyTruck.ancestors
