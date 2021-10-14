Question 3
Building on the prior vehicles question, we now must also track a basic motorboat. A motorboat has a single propeller and hull, but otherwise behaves similar to a catamaran. Therefore, creators of Motorboat instances don/t need to specify number of hulls or propellers. How would you modify the vehicles code to incorporate a new Motorboat class?





Solution 3 #######
We can create a new class to present the common elements of motorboats and catamarans. We can call it, for example, Seacraft. We still want to include the Moveable module to get the support for calculating the range.

Copy Code
class Seacraft
  include Moveable

  attr_reader :hull_count, :propeller_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end
end
We can now implement Motorboat based on the Seacraft definition. We don/t need to include a reference to Moveable since that is already included in the Seacraft super class.

Copy Code
class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # set up 1 hull and 1 propeller
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end
And we alter the Catamaran to inherit from Seacraft and move hull and propeller tracking out since its taken over by Seacraft. We can also remove the reference to the Moveable module.

Copy Code
class Catamaran < Seacraft
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end
The super method automatically receives and passes along any arguments which the original method received. Because of that, we can remove the arguments being passed into super:

Copy Code
class Catamaran < Seacraft
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super
  end
end
In fact, because super is the only statement in this initialize method and there/s nothing to override, we can remove it altogether.

Copy Code
class Catamaran < Seacraft
end