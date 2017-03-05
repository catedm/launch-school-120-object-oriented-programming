class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# The @@cats_count is a class method that keeps a count
# on all of the cat instances we have created

tommy = Cat.new("Kind")
puts Cat.cats_count
bill = Cat.new("Kind")
puts Cat.cats_count
