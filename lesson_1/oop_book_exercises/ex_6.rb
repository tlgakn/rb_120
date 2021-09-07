=begin
Write a method called age that calls a private method to calculate the age of the vehicle. Make sure the private method is not available from outside of the class. You'll need to use Ruby's built-in Time class to help.
=end

class Vehicle
  attr_accessor :color
  attr_reader :model, :year
  @@number_of_vehicles = 0

  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @@number_of_vehicles += 1
  end

  
  def age
    puts "My Car is #{calc_age} years old"
  end
  
  private
  
  def calc_age
    (Time.now.year) - (year.to_i)
  end
  
end

class MyCar < Vehicle

end

my_car = MyCar.new('2012', 'toyota', 'red')
puts my_car.age


