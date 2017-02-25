class MyCar

  attr_accessor :color
  attr_reader :year

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
end

billy = MyCar.new(2002, "red", "Blazer")
billy.speed_up(25)
billy.brake(10)
billy.current_speed
billy.color = "Green"
puts billy.color
puts billy.year
billy.spray_paint("Black")
puts billy.color
