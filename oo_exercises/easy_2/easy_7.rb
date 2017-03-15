require "pry"

class Pet
  attr_reader :type, :name
  @@total_pets = 0

  def initialize(type, name)
    @type = type
    @name = name
    @@total_pets += 1
  end

  def to_s
    "a #{type} named #{name}"
  end

  def self.total_pets
    @@total_pets
  end
end

class Shelter
  attr_reader :unadopted_pets

  def initialize
    @unadopted_pets = []
    @owners = {}
  end

  def add_unadopted_pet(pet)
    @unadopted_pets << pet
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
    @unadopted_pets.delete(pet)
  end

  def print_unadopted_pets
    puts "The Animal Shelter has the following unadopted pets:"
    @unadopted_pets.each { |pet| puts pet }
  end

  def print_unadopted_pets_amount
    puts "The Animal Shelter has #{unadopted_pets.size} unadopted pets."
  end

  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end
end

class Owner
  attr_reader :pets, :name

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def number_of_pets
    pets.size
  end

  def print_pets
    pets.each { |pet| puts pet }
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluffy')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.add_unadopted_pet(butterscotch)
shelter.add_unadopted_pet(pudding)
shelter.add_unadopted_pet(darwin)
shelter.add_unadopted_pet(kennedy)
shelter.add_unadopted_pet(sweetie)
shelter.add_unadopted_pet(molly)
shelter.add_unadopted_pet(chester)
shelter.add_unadopted_pet(asta)
shelter.add_unadopted_pet(laddie)
shelter.add_unadopted_pet(fluffy)
shelter.add_unadopted_pet(kat)
shelter.add_unadopted_pet(ben)
shelter.add_unadopted_pet(chatterbox)
shelter.add_unadopted_pet(bluebell)
shelter.print_unadopted_pets
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
shelter.print_unadopted_pets_amount
