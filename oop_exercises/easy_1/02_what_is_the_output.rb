# What's the Output?
# Take a look at the following code:

Copy Code
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# What output does this code print? Fix this class so that there are no surprises waiting in store for the unsuspecting developer.

#LS Answer
# Corrected Class:
class  Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

# Discussion
# The original version of #to_s uses String#upcase! which mutates its argument in place. This causes @name to be modified, which in turn causes name to be modified: this is because @name and name reference the same object in memory.

# Oh, and that to_s inside the initialize method? We need that for the challenge under Further Exploration.

# Further Exploration
# What would happen in this case?

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

#This code "works" because of that mysterious to_s call in Pet#initialize. However, that doesn't explain why this code produces the result it does. Can you?

# My Answer
class  Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s # @name = '42'
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 42
fluffy = Pet.new(name)
name += 1 # 43
puts fluffy.name # calling the object inside of the class which is string 42
puts fluffy
puts fluffy.name # 
puts name # this is outside of the class scope integer 42 incremented by 1