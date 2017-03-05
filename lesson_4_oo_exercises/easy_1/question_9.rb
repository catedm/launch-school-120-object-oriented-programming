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

# Because this is a class method it represents the class itself, 
# in this case Cat. So you can call Cat.cats_count.
