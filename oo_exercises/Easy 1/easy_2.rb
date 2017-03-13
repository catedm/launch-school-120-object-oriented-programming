require "pry"

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
    binding.pry
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
