Fixed Array
A fixed-length array is an array that always has a fixed number of elements. Write a class that implements a fixed-length array, and provides the necessary methods to support the following code:

Copy Code
fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end
The above code should output true 16 times.


Solution
Copy Code
class FixedArray
  def initialize(max_size)
    @array = Array.new(max_size)
  end

  def [](index)
    @array.fetch(index)
  end

  def []=(index, value)
    self[index]             # raise error if index is invalid!
    @array[index] = value
  end

  def to_a
    @array.clone
  end

  def to_s
    to_a.to_s
  end
end
Discussion
There/s a good chance that your solution inherits from the standard Array class; after all, a fixed-length array is an Array, and the "is a" relationship generally implies the need of inheritance. However, inheriting from Array means you need to verify that all of the standard Array methods will work properly with the fixed-length requirement; that could be a lot of code. Furthermore, it is generally considered bad form to inherit from standard classes; instead, you should use a collaborator object.

We take the collaborative approach with our solution, and the collaborator is a regular Ruby Array. Only those methods we implement will be available to users of the FixedArray class, so we dont need to worry about all of the standard Array methods.

To start, our #initialize takes a single argument that specifies the desired size of the FixedArray, and uses this to initialize @array to max_size elements, all with an initial value of nil.

Our example code shows that we need the [] operator to work when getting element values, and []= operator when setting element values. Both operators should raise an IndexError exception if the index is out of range. To implement the [] operator, we need a #[] method; our implementation uses Array#fetch to retrieve the indicated element; happily, #fetch raises an IndexError exception if the index is out range, so we don't have to do anything special. Our #[]= method uses #[] to make sure an IndexError is raised if needed, but just reuses Array#[]= to assign the value to the indicated element.

The example code also shows that we want a #to_a method to convert a FixedArray object to a regular Array. This method is pretty simple; we just return a copy of the underlying Array collaborator. Note that we use #clone to copy the Array; the caller is requesting an Array version of our instance, and we don't want the caller doing something to that Array that will make our FixedArray inconsistent. For instance, if we did not use #clone, this code:

Copy Code
fa = FixedArray.new(50)
   ...
a = fa.to_a
a.delete_at(0)
would cause fa to have a 49 element Array instead of a 50 element Array. This would likely cause problems. By using #clone, we get a new Array, and don't have to worry about this.

Finally, we can implement #to_s by calling Array#to_s on the return value of #to_a.

Did you notice the begin/rescue/end structure in the test cases? This structure is an "exception handler" - if an exception occurs in the code between the begin and rescue, Ruby skips ahead to the code between the rescue and end. In this case, its looking specifically for the IndexError exception that occurs when you try to access an index that doesn't exist. We're using it as a test in the code above - we want to know for certain that an IndexError occurs when it should. If the exception does not occur, the code displays false. If the IndexError exception occurs as it should, it displays true.