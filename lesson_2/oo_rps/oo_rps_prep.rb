
class Player
  def initialize
    # maybe a "name"? what about a "move"?
  end

  def choose

  end
end

class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)

end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end

end

RPSGame.new.play

# Summary
# This assignment has given you an outline of how to approach solving a problem with an OO mindset. One of the hardest things to understand about OOP is that there is no absolute "right" solution. In OOP, it's all a matter of tradeoffs. However, there are absolutely wrong approaches. For now, your goal is to avoid the wrong approaches, and understand the core concepts of OOP. Don't worry about finding the most optimal architecture or design. Object oriented design and architecture is a huge topic in itself, and it's going to take years (maybe decades!) to master that.

# In the next assignment, we'll continue on where we left off here and go on an exploratory coding spree to better understand the problem.