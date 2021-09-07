# Pet Shelter
# Consider the following code:

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

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
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

#Write the classes and methods that will be necessary to make this code run, and print the following output:

P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.

# The order of the output does not matter, so long as all of the information is presented.

Solution
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
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
  end

  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end
end

Discussion
# This is a somewhat contrived example of an animal shelter's adoption records. Our solution isn't the only solution, nor is it necessarily the best solution; it is simply a possible solution that isn't too difficult to comprehend in one sitting.

# Our example code provides most of the details we need, such as class and (most) method names, and what the output is supposed to look like. Some details are left to your imagination.

# We start by defining our Pet class, which is extremely simple. All we need is an initialize method that sets the pet's type and name, and a couple of getter methods so we can retrieve these names. We also provide a to_s method override so we can convert Pet objects into meaningful strings; this will be useful from Owner#print_pets.

# Next comes the Owner class, which, based on the example code, only needs to support 2 methods: initialize and number_of_pets. Since number_of_pets is going to be an Owner instance method, we decide that we will also store a list of each owner's adopted pets in the Owner object. So, we initialize @pets, add a getter method for @pets, and a method add_pet to add a newly adopted pet to the owner record. Finally, we will also need a print_pets method so we can print the list of the owner's pets.

# The Shelter class needs initialize, adopt and print_adoptions methods to match the example code. The adopt method adds a new pet to the owner record, and then adds the owner record to our @owners instance hash, but only if the owner is not already listed. (We assume here that there are no owners with matching names, and that we will never create multiple Owner objects for the same owner.) Finally, print_adoptions iterates through our owner list, printing their name and a list of the pets the owner has adopted.

# This exercise is about collaborator objects; instance variables don't have to be simple variables like numbers and strings, but can contain any object that might be needed. In our solution, the Pet class has two String collaborator objects, Owner has a String and an Array of Pet objects, and Shelter has a Hash of Owner objects.

Further Exploration

# Add your own name and pets to this project.

# Suppose the shelter has a number of not-yet-adopted pets, and wants to manage them through this same system. Thus, you should be able to add the following output to the example output shown above:

The Animal Shelter has the following unadopted pets:
a dog named Asta
a dog named Laddie
a cat named Fluffy
a cat named Kat
a cat named Ben
a parakeet named Chatterbox
a parakeet named Bluebell
   ...

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
The Animal shelter has 7 unadopted pets.

# Can you make these updates to your solution? Did you need to change your class system at all? Were you able to make all of your changes without modifying the existing interface?


# Student 1
# My further exploration solution is a tad bit different. I used a Hash to track @adoptions. I also made the Owner class a collaborator object in Shelter called @animal_shelter. To differentiate between shelters I added a parameter called animal_shelter to the Shelter class constructor. This gives different Shelters the ability to own pets. I changed the Shelter#adopt method definition and made the owner parameter default value the @animal_shelter itself. Lastly, I added Owner#increment_pets and Owner#decrement_pets to keep track of the number of pets.
class Shelter
  attr_reader :adoptions, :animal_shelter

  def initialize(animal_shelter)
    @adoptions = Hash.new([])
    @animal_shelter = Owner.new(animal_shelter)
  end

  def adopt(owner=@animal_shelter, pet)
    update_pets(pet)
    adoptions[owner] += [pet]
    owner.increment_pets
  end

  def update_pets(pet)
    adoptions.each do |owner, pets|
      next unless pets.include?(pet) 
      pets.delete(pet)
      owner.decrement_pets
    end
  end

  def print_adoptions
    adoptions.each do |owner, pets|
      case owner
      when animal_shelter
        puts "The #{owner.name} has the following unadopted pets:"
      else
        puts "#{owner.name} has adopted the following pets:"
      end
      pets.each do |pet|
        puts pet
      end
      puts
    end
  end
end

class Pet
  attr_reader :kind, :name

  def initialize(kind, name)
    @kind = kind
    @name = name
  end

  def to_s
    "a #{kind} named #{name}"
  end
end

class Owner
  attr_reader :name
  attr_accessor :number_of_pets

  def initialize(name)
    @name = name
    @number_of_pets = 0
  end

  def increment_pets
    self.number_of_pets += 1
  end

  def decrement_pets
    self.number_of_pets -= 1
  end
end
butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

casper       = Pet.new('parakeet', 'Casper')
jaden        = Pet.new('dog', 'Jaden')
cooper       = Pet.new('dog', 'Cooper')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new("Animal Shelter")
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.adopt(casper)
shelter.adopt(jaden)
shelter.adopt(cooper)

shelter.adopt(phanson, jaden)

shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The #{shelter.animal_shelter.name} has #{shelter.animal_shelter.number_of_pets} adopted pets."

# Student 2
class Pet
  attr_reader :animal, :name

  def initialize(animal, name)
    @animal = animal
    @name   = name
  end

  def to_s
    "a #{animal} named #{name}"
  end
end

class Owner
  attr_reader :name
  attr_accessor :number_of_pets, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    pets.size
  end
end

class Shelter
  attr_accessor :adopters, :available_pets

  def initialize(*available_pets)
    @adopters       = []
    @available_pets = available_pets
  end

  def available_pet_count
    available_pets.size
  end

  def adopt(owner, pet)
    owner.pets << pet
    available_pets.delete(pet)
    adopters << owner unless adopters.include?(owner)
  end

  def print_available_pets
    puts "The Animal Shelter has the following unadopted pets:"
    puts available_pets; puts "\n"
  end

  def print_adoptions
    adopters.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      puts owner.pets; puts "\n"
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

asta       = Pet.new('dog', 'Asta')
laddie     = Pet.new('dog', 'Laddie')
fluffy     = Pet.new('cat', 'Fluffy')
kat        = Pet.new('cat', 'Kat')
ben        = Pet.new('cat', 'Ben')
chatterbox = Pet.new('parakeet', 'Chatterbox')
bluebell   = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new(butterscotch, pudding, darwin, kennedy, sweetie, molly, chester, asta, laddie, fluffy, kat, ben, chatterbox, bluebell)
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
shelter.print_available_pets
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts ""
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts ""
puts "The Animal shelter has #{shelter.available_pet_count} unadopted pets."


