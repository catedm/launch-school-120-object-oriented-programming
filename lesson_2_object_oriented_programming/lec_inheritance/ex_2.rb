module Swim
  def swim
    "swimming!"
  end
end

class Pet
  def run
    'running'
  end

  def jump
    'jumping'
  end
end

class Dog < Pet
  include Swim

  def speak
    'bark!'
  end

  def fetch
    'fetching'
  end
end

class Cat < Pet
  def speak
    'meow'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

p Dog.ancestors
