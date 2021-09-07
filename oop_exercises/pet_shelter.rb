# class Pet
#   attr_reader :animal, :name

#   def initialize(animal, name)
#     @animal = animal
#     @name = name
#   end

#   def to_s
#     "a #{animal} named #{name}"
#   end
# end

# class Owner
#   attr_reader :name, :pets

#   def initialize(name)
#     @name = name
#     @pets = []
#   end

#   def add_pet(pet)
#     @pets << pet
#   end
  
#   def number_of_pets
#     pets.size
#   end

#   def print_pets
#     puts pets
#   end
# end

# class Shelter
#   def initialize
#     @owners = {}
#     @unadopted = []
#   end
 
#   def adopt(owner= '', pet)
#     if owner.to_s == owner
#       @unadopted << pet
#     else
#       owner.add_pet(pet)
#       @owners[owner.name] ||= owner
#     end
#   end

#   def print_adoptions
#     @owners.each_pair do |name, owner|
#       puts "#{name} has adopted the following pets:"
#       owner.print_pets
#       puts
#     end
#   end
  
#   def print_unadopted
#     puts "The Animal shelter has the following unadopted pets:"
#     @unadopted.each do |pet|
#       puts pet
#     end
#   end
#   def number_of_unadopted
#     @unadopted.size
#   end
# end


# butterscotch = Pet.new('cat', 'Butterscotch')
# pudding      = Pet.new('cat', 'Pudding')
# darwin       = Pet.new('bearded dragon', 'Darwin')
# kennedy      = Pet.new('dog', 'Kennedy')
# sweetie      = Pet.new('parakeet', 'Sweetie Pie')
# molly        = Pet.new('dog', 'Molly')
# chester      = Pet.new('fish', 'Chester')
# asta         = Pet.new('dog', 'Asta')
# laddie       = Pet.new('dog', 'Laddie')
# fluffy       = Pet.new('cat', 'Fluffy')
# kat          = Pet.new('cat', 'Kat')
# ben          = Pet.new('cat', 'Ben')
# chatterbox   = Pet.new('parakeet', 'Chatterbox')
# bluebell     = Pet.new('parakeet', 'Bluebell')


# phanson   = Owner.new('P Hanson')
# bholmes   = Owner.new('B Holmes')

# shelter = Shelter.new
# shelter.adopt(phanson, butterscotch)
# shelter.adopt(phanson, pudding)
# shelter.adopt(phanson, darwin)
# shelter.adopt(bholmes, kennedy)
# shelter.adopt(bholmes, sweetie)
# shelter.adopt(bholmes, molly)
# shelter.adopt(bholmes, chester)
# shelter.adopt(asta)
# shelter.adopt(laddie)
# shelter.adopt(fluffy)
# shelter.adopt(kat)
# shelter.adopt(ben)
# shelter.adopt(chatterbox)
# shelter.adopt(bluebell)

# shelter.print_adoptions
# shelter.print_unadopted
# puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
# puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
# puts "The Animal shelter has #{shelter.number_of_unadopted} pets."

### Second time
class Pet
  attr_reader :animal, :name

  def initialize(animal, name)
    @animal = animal
    @name = name
  end

  def to_s
    "a #{animal} named #{name}"
  end
end

class Owner
  attr_reader :name, :pets
  
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
    puts pets
  end
  
end

class Shelter
  def initialize
    @owners = {}
    @unadopted = []
  end
  
  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
  end
  
  def to_adopt(pet)
    @unadopted << pet
  end
  
  def unadopted_size
    @unadopted.size
  end
  
  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end
  
  def print_unadopted
    puts "The Animal Shelter has the following unadopted pets:"
    @unadopted.each do |pet|
      puts pet
    end
  end
  
end


butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
karabas = Pet.new('dog', 'Karabas')

asta       = Pet.new('dog', 'Asta')
laddie     = Pet.new('dog', 'Laddie')
fluffy     = Pet.new('cat', 'Fluffy')
kat        = Pet.new('cat', 'Kat')
ben        = Pet.new('cat', 'Ben')
chatterbox = Pet.new('parakeet', 'Chatterbox')
bluebell   = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new

shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
puts 
shelter.to_adopt(asta)
shelter.to_adopt(laddie)
shelter.to_adopt(fluffy)
shelter.to_adopt(kat)
shelter.to_adopt(ben)
shelter.to_adopt(chatterbox)
shelter.to_adopt(bluebell)

shelter.print_unadopted
puts 
shelter.print_adoptions

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal shelter has #{shelter.unadopted_size} unadopted pets."
