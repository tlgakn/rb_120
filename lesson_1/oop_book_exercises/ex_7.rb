# Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, so joe.grade will raise an error. Create a better_grade_than? method, that you can call like so...

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(other_student)
    grade > other_student.grade
  end
  
  protected
  attr_reader :grade
  
end

bob = Student.new('Bob', 85)
joe = Student.new('Joe', 97)
puts "Well done!" if joe.better_grade_than?(bob)
