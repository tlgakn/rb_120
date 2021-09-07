# Fix the Program - Books (Part 1)
# Complete this program so that it produces the expected output:

class Book
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

#Expected output:

#Copy Code
# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

#Solution
#dd the following code to the class (between lines 1 and 2 will be fine):

Copy Code
# attr_reader :author, :title
# Discussion
# If you try to run the original code, you'll see something like this:

# Copy Code
# x.rb:13:in `<main>': undefined method `title' for #<Book:0x007f8504842930> (NoMethodError)
# Hmm... title is undefined at line 13 where we are attempting to retrieve the book title by calling the title method. So, you add:

# Copy Code
# attr_reader :title
# to the class definition. You run your code again, and this time get:

# Copy Code
# x.rb:15:in `<main>': undefined method `author' for #<Book:0x007fac948565b8> (NoMethodError)
# It looks like we also need a getter for @author:

# Copy Code
# attr_reader :author, :title
# The code will now run as expected.



# Further Exploration
# What are the differences between attr_reader, attr_writer, and attr_accessor? Why did we use attr_reader instead of one of the other two? Would it be okay to use one of the others? Why or why not?

# Instead of attr_reader, suppose you had added the following methods to this class:

# Copy Code
# def title
#   @title
# end

# def author
#   @author
# end
# Would this change the behavior of the class in any way? If so, how? If not, why not? Can you think of any advantages of this code?

# Student Answer
# The attr methods are essentially shorthand for creating getter and setter methods. attr_reader creates a getter method, attr_writer creates a setter method and attr_accessor creates both a getter and a setter.

# In this example we only needed to get the value of the @author and @title instance variables, so even if we tried, the attr_writer method wouldn't allow us to get anything, only set or override the instance variables. The attr_accessor method would allow us to get the @author and @title instance variables, but also override them. Assuming that these books are published, it would not be okay to change their title or author.

# By explicitly writing the getter methods we add a lot of unnecessary code to our class which will behave in the same way as using the attr_reader method.

# The benefit however of explicitly writing getters or setters is that we can manipulate their implementation with more detail than by using any of the attr methods.

# For example, say that for security we didn't want our author getter to return the String object that @author is pointing to. Maybe we don't want any client code mutating it with an upcase! or delete!. We could instead return a copy of @author in the getter like so:

# Copy Code
# def author
#    @author.dup
# end
# Even if we attempted to use malicious or destructive code such as:

# Copy Code
# book.author.each_char { |char| book.author.delete!(char) }
# The value of the String object that @author is pointing to would remain unchanged.
