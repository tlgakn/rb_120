# Refactoring Vehicles
# Consider the following classes:

class Car
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    4
  end

  def to_s
    "#{make} #{model}"
  end
end

class Motorcycle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    2
  end

  def to_s
    "#{make} #{model}"
  end
end

class Truck
  attr_reader :make, :model, :payload

  def initialize(make, model, payload)
    @make = make
    @model = model
    @payload = payload
  end

  def wheels
    6
  end

  def to_s
    "#{make} #{model}"
  end
end
#Refactor these classes so they all use a common superclass, and inherit behavior as needed.

Solution

class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

Discussion
# Our first task is to decide on an appropriate class name for our superclass. It should be a more general type than the individual class names. A good name here is Vehicle, since cars, motorcycles, and trucks are all types of vehicles.

# All of our initializers take make and model parameters, and store them in @make and @model instance variables. We can refactor all of this commonality into Vehicle by moving initialize from one of the classes into Vehicle, and deleting it from both Car and Motorcycle. However, our Truck class takes a 3rd parameter payload, so we can't just delete Truck#initialize. We can (and should!) simplify it a bit by using super to initialize the superclass.

# By similar reasoning, we can also move our attr_reader for :make and :model into Vehicle, but we need to remember to keep the :payload attr_reader defined in Truck.

# Our to_s method is identical in all 3 of the original classes, so we just move that into Vehicle and remove it from the original classes.

# The wheels method is different in each of the original classes, so we don't move this into Vehicle.

Further Exploration
# Would it make sense to define a wheels method in Vehicle even though all of the remaining classes would be overriding it? Why or why not? If you think it does make sense, what method body would you write?