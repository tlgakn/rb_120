require 'pry'

class Move
  attr_reader :value

  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

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

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
  end

  def >(other_move)
    value && (other_move.scissors? || other_move.lizard?)
  end

  def <(other_move)
    value && (other_move.paper? || other_move.spock?)
  end

end

class Paper < Move
  def initialize
    @value = 'paper'
  end

  def >(other_move)
    value && (other_move.rock? || other_move.spock?)
  end

  def <(other_move)
    value && (other_move.scissors? || other_move.lizard?)
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
  end

  def >(other_move)
    value && (other_move.paper? || other_move.lizard?)
  end

  def <(other_move)
    value && (other_move.rock? || other_move.spock?)
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
  end

  def >(other_move)
    value && (other_move.paper? || other_move.spock?)
  end

  def <(other_move)
    value && (other_move.rock? || other_move.scissors?)
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
  end

  def >(other_move)
    value && (other_move.rock? || other_move.scissors?)
  end

  def <(other_move)
    value && (other_move.paper? || other_move.lizard?)
  end
end

class Player
  attr_accessor :move, :name, :score, :move_history

  def initialize
    set_name
    @score = 0
    @move_history = []
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
      puts "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice"
    end
    self.move = Kernel.const_get(choice.capitalize).new
    move_history << move
  end
end

class Computer < Player
  ROBOTS = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number5']
end

class R2D2 < Computer
  def set_name
    self.name = 'R2D2'
  end

  def choose
    self.move = Rock.new
    move_history << move
  end
end

class Hal < Computer
  def set_name
    self.name = 'Hal'
  end

  def choose
    self.move = [Scissors.new, Scissors.new, Scissors.new, Rock.new].sample
    move_history << move
  end
end

class Chappie < Computer
  def set_name
    self.name = 'Chappie'
  end

  def choose
    self.move = Paper.new
    move_history << move
  end
end

class Sonny < Computer
  def set_name
    self.name = 'Sonny'
  end

  def choose
    self.move = [Lizard.new, Spock.new].sample
    move_history << move
  end
end

class Number5 < Computer
  @@round = 0

  def set_name
    self.name = 'Number 5'
  end

  def choose
    self.move = [Rock.new, Paper.new, Scissors.new,
                 Lizard.new, Spock.new][@@round]
    move_history << move
    @@round >= 4 ? @@round = 0 : @@round += 1
  end
end



class RPSGame
  WINNING_SCORE = 2
  
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
  end

  def set_initial_score_and_opponent
    system('clear') || system('cls')
    self.computer = Kernel.const_get(Computer::ROBOTS.sample).new
    human.score = 0
    computer.score = 0
  end

  def display_welcome_message
    puts "Hi #{human.name}, Welcome to Rock, Paper, Scissors, Lizard and Spock Game!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard and Spock Game. Good bye!"
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

  def display_round_winner
    if human.move > computer.move
      puts "#{human.name} won this round!"
      puts
    elsif human.move < computer.move
      puts "#{computer.name} won this round!"
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

  def print_history
    puts ""
    puts "The following is #{human.name}'s move history:"
    puts human.move_history
    puts "-------------------"
    puts "The following is #{computer.name}'s move history:"
    puts computer.move_history
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
        display_round_winner
        update_score
        display_score
        break if grand_winner?
        user_clear_screen
      end
      display_grand_winner
      print_history
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play