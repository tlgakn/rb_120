Number Guesser Part 1
Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like this:

Copy Code
game = GuessingGame.new
game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
That/s the number!

You won!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high.

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high.

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have no more guesses. You lost!
Note that a game object should start a new game with a new number to guess with each call to #play.


Solution
Copy Code
class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100

  RESULT_OF_GUESS_MESSAGE = {
    high:  "Your number is too high.",
    low:   "Your number is too low.",
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high:  :lose,
    low:   :lose,
    match: :win
  }.freeze

  RESULT_OF_GAME_MESSAGE = {
    win:  "You won!",
    lose: "You have no more guesses. You lost!"
  }.freeze

  def initialize
    @secret_number = nil
  end

  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  def reset
    @secret_number = rand(RANGE)
  end

  def play_game
    result = nil
    MAX_GUESSES.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(obtain_one_guess)
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def obtain_one_guess
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      guess = gets.chomp.to_i
      return guess if RANGE.cover?(guess)
      print "Invalid guess. "
    end
  end

  def check_guess(guess_value)
    return :match if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end

  def display_game_end_message(result)
    puts "", RESULT_OF_GAME_MESSAGE[result]
  end
end
Discussion
Our class begins with some constants: the number of guesses allowed per game, the range for the secret number, and three Hashes that we use to print messages without a lot of logic. None of these constants are necessary, but each helps to make our code clearer.

Most classes need an #initialize method to initialize its internal state. That isn't necessary here since we don't need to choose a secret number until play begins. It's good practice, though, to always initialize your instance variables in the #initialize method, even if you don't have to. It provides a single location where you can see all your instance variables.

The #play method handles each round of the game:

It calls #reset to reset the game, that is, generate a new secret number.
It calls #play_game to play a single round, and returns the result (:win if the player wins, :lose otherwise).
We use the result to display the game end message with #display_game_end_message.
#play_game is the meat of the game: it asks the player for each guess, but no more than allowed. If the player guesses the number, the method returns :win. Otherwise, it returns :lose.

The loop in #play_game calls #obtain_one_guess to get a number from the player. This method should be familiar; you've written plenty like it so far in your Launch School experience. The call to #cover? may be unfamiliar; #cover? is a Range method like the familiar #include? method, but is much faster than #include? when working with Ranges.

We also call #check_guess with the guessed number, which determines whether it's equal to, less than, or greater than the secret number, and returns the result as a symbol. We use that symbol in #play_game to print the appropriate result message from RESULT_OF_GUESS_MESSAGE.

#display_guesses_remaining displays the number of guesses remaining.

Further Exploration
You will need the original exercise solution for the next exercise. If you work on this Further Exploration, keep a copy of your original solution so you can reuse it.

We took a straightforward approach here and implemented a single class. Do you think it/s a good idea to have a Player class? What methods and data should be part of it? How many Player objects do you need? Should you use inheritance, a mix-in module, or a collaborative object?

  # Student Solution (Ginni)
  class GuessingGame
    RANGE = (1..100).to_a
    MAX_GUESSES = 7
  
    attr_accessor :guesses, :guess
    attr_reader :number
  
    def initialize
      @guesses = MAX_GUESSES
      @number = generate_number
    end
  
    def play
      #clear
      loop do
        show_remaining_guesses
        self.guess = ask_valid_number
        break if number_guessed?
        show_over_under
        self.guesses -= 1
        break if out_of_guesses?
      end
      show_results
      reset
    end
  
    private
  
    def clear
      system "clear"
    end
  
    def generate_number
      RANGE.sample
    end
  
    def reset
      @guesses = MAX_GUESSES
      @number = generate_number
    end
  
    def show_remaining_guesses
      puts "You have #{guesses} guesses remaining."
    end
  
    def ask_valid_number
      answer = nil
      loop do
        print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
        answer = gets.chomp
        break if valid_number?(answer)
        puts "Invalid guess. "
      end
  
      answer.to_i
    end
  
    def valid_number?(str)
      str =~ /\A[-+]?\d+\z/ && RANGE.include?(str.to_i)
    end
  
    def number_guessed?
      guess == number
    end
  
    def show_over_under
      if guess < number
        puts "Your guess is too low."
      elsif guess > number
        puts "Your guess is too high."
      end
    end
  
    def out_of_guesses?
      guesses == 0
    end
  
    def show_results
      if number_guessed?
        puts "That's the number!"
        puts ""
        puts "You won!"
      elsif out_of_guesses?
        puts "You have no more guesses. You lost!"
      end
    end
  end
  
  game = GuessingGame.new
  game.play
  game.play

  # My Approach (not a complete solution yet)
  class GuessingGame
    attr_accessor :user_guess, :guess_total
    attr_reader :guess_number
    
    def initialize
      @guess_number = rand(1..100)
      @guess_total = 7
      @user_guess = nil
    end
    
    def display_guesses
      puts "You have #{guess_total} remaining"
    end
    
    def display_prompt_guess
      loop do 
        puts "Enter a number between 1 and 100:"
        self.user_guess = gets.chomp.to_i
        break if (1..100).to_a.include?(user_guess)
        puts "Invalid guess. Enter a number between 1 and 100:"
      end
    end
    
    def display_guess_tip
      if user_guess > guess_number
        puts "Your guess is too high."
      elsif user_guess < guess_number
        puts "Your guess is too low."
      end
    end
    
    def user_won?
      user_guess == guess_number
    end
    
    def no_more_guess?
      guess_total == 0
    end
    
    def decrement_guess
      self.guess_total -= 1
    end
    
    def display_end_message
      if user_won?
        puts "You won!"
      elsif no_more_guess?
        puts "You have no more guesses. You lost!"
      end
    end
    
    def play
      loop do
        display_guesses
        display_prompt_guess
        break if user_won? || no_more_guess?
        display_guess_tip
        decrement_guess
        display_end_message
      end
    end
  end
  
  
  game = GuessingGame.new
  game.play
  

# Student Solution (Sean Ricbardson)
While I thought it unnecessary, I created a second class, RandomNumber for fun.

Copy Code
lass RandomNumber
  def initialize(low, high)
    @num = rand(low..high)
  end

  def <(other_num)
    @num < other_num
  end

  def >(other_num)
    @num > other_num
  end

  def ==(other_num)
    @num == other_num
  end

  def to_s
    @num.to_s
  end
end

class GuessingGame
  LOW_LIMIT = 1
  HIGH_LIMIT = 100
  INITIAL_GUESSES = 7

  attr_accessor :guess, :number

  def play
    @number = RandomNumber.new(LOW_LIMIT, HIGH_LIMIT)
    @guesses_left = INITIAL_GUESSES
    loop do
      puts ""
      display_remaining_guesses
      get_guess
      @guesses_left -= 1
      break if correct_guess? || @guesses_left == 0
      display_hint
    end
    display_results
  end

  def display_remaining_guesses
    puts "You have #{@guesses_left} remaining."
  end

  def display_hint
    if number > guess
      puts "Your guess is too low"
    else
      puts "Your guess is too high"
    end
  end

  def display_results
    if correct_guess?
      puts "You won!"
    else
      puts "You've run out of guesses, better luck next time!"
    end
  end

  def correct_guess?
    number == guess
  end

  def get_guess
    answer = 0
    loop do
      print "Enter a number between #{LOW_LIMIT} and #{HIGH_LIMIT}: "
      answer = gets.chomp.to_i
      break if (LOW_LIMIT..HIGH_LIMIT).include?(answer)
      print "Invalid guess. "
    end
    self.guess = answer
  end
end
In regards to the Further Exploration:

In this instance, I see no need for a Player class. In this version of the game no player state, except maybe the guess. If we wanted to keep track of wins or past guesses or if there were more than one player, it might make sense to have a Player class. If I were to create a Player class, each Player object would be used as a collaborative object, much like we did in TTT and 21.