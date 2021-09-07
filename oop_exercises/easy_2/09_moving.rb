# Moving
# You have the following classes.

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

#You need to modify the code so that this works:

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

# You are only allowed to write one new method to do this.

Solution
module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

# In each class you then include Walkable like this:
class Person
  attr_reader :name

  include Walkable

  # Omitted for brevity
end

Discussion
# You can use the Walkable module as a mixin with any class that defines gait and name. You can also define a parent class and make the other classes inherit from that class.

# However, if you recall from the OOP book, modules are more appropriate in a has-a relationship. While it is sometimes tricky to choose one or the other, a great guideline is to decide if you want some additional functionality, or if you want to extend the abilities of the class. In this case, it is pretty clear that we need the functionality of walking; we don't need to extend the abilities of class Person(extending the abilities of a class coincides with an is-a relationship, not has-a).