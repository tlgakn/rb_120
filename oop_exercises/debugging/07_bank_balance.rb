Bank Balance
We created a simple BankAccount class with overdraft protection, that does not allow a withdrawal greater than the amount of the current balance. We wrote some example code to test our program. However, we are surprised by what we see when we test its behavior. Why are we seeing this unexpected output? Make changes to the code so that we see the appropriate behavior.

Copy Code
class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if amount > 0
      success = (self.balance -= amount)
    else
      success = false
    end

    if success
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def balance=(new_balance)
    if valid_transaction?(new_balance)
      @balance = new_balance
      true
    else
      false
    end
  end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
                          # Actual output: $80 withdrawn. Total balance is $50.
p account.balance         # => 50


Hint #1
The bug in this code is extremely subtle. Think about what assignment returns in other contexts. The return value of an assignment is completely predictable from what appears on the right side of the = in the assignment.

Hint #2
Is #balance= returning what you the code suggests it is returning?

Solution
Copy Code
class BankAccount
   # code omitted

  def withdraw(amount)
    if amount > 0 && valid_transaction?(balance - amount)
      self.balance -= amount
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def balance=(new_balance)
    @balance = new_balance
  end

  # code omitted
end
Discussion
In Ruby, setter methods always return the argument that was passed in, even when you add an explicit return statement. Our balance= method will therefore always return its argument, irrespective of whether or not the instance variable @balance is re-assigned.

Because of this behavior, the invocation of balance= on line 21 of the original code will have a truthy return value even when our setter method does not re-assign @balance; it will never return false.

A better solution is to check the validity of the transaction by calling valid_transaction? in withdraw instead of balance=. If the transaction is deemed valid, we then invoke balance=, otherwise we don't. This way we don't attempt to use the setter for its return value, but instead let it do its one job: assigning a value to @balance.

Further Exploration
What will the return value of a setter method be if you mutate its argument in the method body?