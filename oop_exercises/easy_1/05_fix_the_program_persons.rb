# Fix the Program - Persons
# Complete this program so that it produces the expected output:

Copy Code
class Person
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person
#Expected output:

# Copy Code
# John Doe
# Jane Smith
# Hide Solution & Discussion

#Solution
#Add the following methods to the Person class:

#Copy Code
def first_name= (value)
  @first_name = value.capitalize
end

def last_name= (value)
  @last_name = value.capitalize
end

# Discussion
# If you run the original code as-is, you'll get the following error:

# Copy Code
# x.rb:15:in `<main>': undefined method `first_name=' for #<Person:0x007f8b33042980 @first_name="John", @last_name="Doe"> (NoMethodError)
# This is telling you that ruby is looking for a method named first_name= to set the value of the @first_name instance variable. You recognize that a shortcut for such a method can be defined with:

# Copy Code
# attr_writer :first_name
# so add that to your class. Since you can see that you're also going to need a writer for @last_name, you add :last_name to that line as well:

# Copy Code
# attr_writer :first_name, :last_name
# You run the code again, and get the following output:

# Copy Code
# John Doe
# jane smith
# That's almost what we want, but not quite: Jane Smith's name is not capitalized. This is due to the fact that attr_writer doesn't do anything but assign a value directly to an instance variable. We want the name to be capitalized instead (and we should not expect the caller to do it for us). So, we remove the attr_writer call, and add the following setter methods:

# Copy Code
# def first_name= (value)
#   @first_name = value.capitalize
# end

# def last_name= (value)
#   @last_name = value.capitalize
# end
# Now our program will run as expected.