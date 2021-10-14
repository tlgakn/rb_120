Question 4
The designers of the vehicle management system now want to make an adjustment for how the range of vehicles is calculated. For the seaborne vehicles, due to prevailing ocean currents, they want to add an additional 10km of range even if the vehicle is out of fuel.

Alter the code related to vehicles so that the range for autos and motorcycles is still calculated as before, but for catamarans and motorboats, the range method will return an additional 10km.




Solution 4 ####
We can over-ride the range method in the Seacraft class. This means that the range method of the Moveable module will continue to be effective for the autos and motorcycles, but that calling range on catamarans and motorboats will be handled by the range method defined on the Seacraft class and take precedence.

We can use the super keyword to get the value from the Moveable module that/s included by Seacraft, and then add the additional 10km of range before returning it.

Copy Code
class Seacraft

  # ... existing Seacraft code omitted ...

  # the following is added to the existing Seacraft definition
  def range
    super + 10
  end
end
