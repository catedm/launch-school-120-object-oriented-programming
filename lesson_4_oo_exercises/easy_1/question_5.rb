class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

hot_pizza = Pizza.new("Cheese")
orange = Fruit.new("apple")

hot_pizza.instance_variables
orange.instance_variables
