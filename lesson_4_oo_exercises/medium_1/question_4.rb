class Greeting
  def greet(greeting)
    puts greeting
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

testing = Goodbye.new
testing.bye
testing2 = Hello.new
testing2.hi
