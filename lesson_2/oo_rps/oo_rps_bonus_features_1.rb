class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  WINNING_SCORE = 2
  
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def set_initial_score_and_opponent
    system('clear') || system('cls')
    computer.set_name
    human.score = 0
    computer.score = 0
  end

  def display_welcome_message
    puts "Hi #{human.name}, Welcome to Rock, Paper, Scissors Game!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors Game. Good bye!"
  end

  def display_moves
    puts
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    puts
  end

  def update_score
    if human.move > computer.move
      human.score += 1
    elsif human.move < computer.move
      computer.score += 1
    end
  end

  def display_score
    puts "#{human.name} : #{human.score} "
    puts "#{computer.name} : #{computer.score}"
    puts
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      puts
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      puts
    else
      puts "It's a tie!"
    end
  end

  def auto_clear_screen
    system('clear') || system('cls')
  end

  def user_clear_screen
    puts "Please press enter for next round"
    gets
    system('clear') || system('cls')
  end

  def grand_winner?
    human.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def display_grand_winner
    if human.score == WINNING_SCORE
      puts "#{human.name} is the grand winner!"
    elsif computer.score == WINNING_SCORE
      puts "#{computer.name} is the grand winner!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def play
    display_welcome_message
    sleep(2)
    loop do
      set_initial_score_and_opponent
      auto_clear_screen
      loop do
        human.choose
        computer.choose
        display_moves
        display_winner
        update_score
        display_score
        break if grand_winner?
        user_clear_screen
      end
      display_grand_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play