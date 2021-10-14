Poker!
In the previous two exercises, you developed a Card class and a Deck class. You are now going to use those classes to create and evaluate poker hands. Create a class, PokerHand, that takes 5 cards from a Deck of Cards and evaluates those cards as a Poker hand. If you/ve never played poker before, you may find this overview of poker hands useful.

You should build your class using the following code skeleton:

Copy Code
# Include Card and Deck classes from the last two exercises.

class PokerHand
  def initialize(deck)
  end

  def print
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
  end

  def straight_flush?
  end

  def four_of_a_kind?
  end

  def full_house?
  end

  def flush?
  end

  def straight?
  end

  def three_of_a_kind?
  end

  def two_pair?
  end

  def pair?
  end
end
Testing your class:

Copy Code
hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'

Output:
5 of Clubs
7 of Diamonds
Ace of Hearts
7 of Clubs
5 of Spades
Two pair
true
true
true
true
true
true
true
true
true
true
true
true
true
The exact cards and the type of hand will vary with each run.

Most variants of Poker allow both Ace-high (A, K, Q, J, 10) and Ace-low (A, 2, 3, 4, 5) straights. For simplicity, your code only needs to recognize Ace-high straights.

If you are unfamiliar with Poker, please see this description of the various hand types. Since we won/t actually be playing a game of Poker, it isn/t necessary to know how to play.




Solution ############

Copy Code
class PokerHand
  def initialize(cards)
    @cards = []
    @rank_count = Hash.new(0)

    5.times do
      card = cards.draw
      @cards << card
      @rank_count[card.rank] += 1
    end
  end

  def print
    puts @cards
  end

  def evaluate
    if    royal_flush?     then 'Royal flush'
    elsif straight_flush?  then 'Straight flush'
    elsif four_of_a_kind?  then 'Four of a kind'
    elsif full_house?      then 'Full house'
    elsif flush?           then 'Flush'
    elsif straight?        then 'Straight'
    elsif three_of_a_kind? then 'Three of a kind'
    elsif two_pair?        then 'Two pair'
    elsif pair?            then 'Pair'
    else 'High card'
    end
  end

  private

  def flush?
    suit = @cards.first.suit
    @cards.all? { |card| card.suit == suit }
  end

  def straight?
    return false if @rank_count.any? { |_, count| count > 1 }

    @cards.min.value == @cards.max.value - 4
  end

  def n_of_a_kind?(number)
    @rank_count.one? { |_, count| count == number }
  end

  def straight_flush?
    flush? && straight?
  end

  def royal_flush?
    straight_flush? && @cards.min.rank == 10
  end

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    n_of_a_kind?(3) && n_of_a_kind?(2)
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    @rank_count.select { |_, count| count == 2 }.size == 2
  end

  def pair?
    n_of_a_kind?(2)
  end
end
Discussion
Our starting code shows that PokerHand objects are created with PokerHand.new with a Deck object passed in as an argument. We can also see that the PokerHand class has an instance variable named @cards that contains the cards in the hand.

Our solution starts by initializing @cards as an Array, and a Hash that keeps track of the number of cards of each rank. This is handy information to have since poker hands are evaluated by counting cards of various ranks. Our original draft of this method also included another Hash to count the number of cards in each suit, but after refactoring our solution, we decided we didn't really need it, so we don't provide such a Hash in our final solution.

After this, all that remains is to write the code for each possible hand type. Our evaluate method checks for each hand type in highest value to lowest value order (we check royal flushes before straight flushes, for instance), and all of the methods used to determine the hand type are private. This helps to simplify our methods greatly; for example, our #straight? method doesn't need to check whether the hand is a straight flush because our #straight_flush? method is guaranteed to be called first via #evaluate.

To aid in our explanation, we/ve rearranged the private methods.

The  "#"flush? method determines whether a hand is a flush - that is, all of the cards are in the same suit. We accomplish this by comparing the suit of the first card to the suits of all the other cards, returning true if all cards have the same suit, false otherwise.

"#"straight? detects straights - any sequence of 5 consecutive cards. For this to be true, the count for each rank in the hand must be 1. If any ranks have one or more duplicates, the hand can/t possibly be a straight. The rest of the method returns true in the lowest ranking card and highest ranking card have values that differ by exactly 4. We use Enumerable#min and Enumerable#max to determine the lowest and highest ranking cards, and these two methods both use Card#<=> to compare cards.

#n_of_a_kind? returns true if there is exactly one rank in the hand that occurs exactly number times. This method makes use of the @rank_count Hash that we defined and built-in #one? method.

#straight_flush? is simple enough: to be a straight flush, the hand must be both a straight and a flush.

#royal_flush? is similar, but also requires that the lowest ranking card be a 10.

#four_of_a_kind? uses #n_of_a_kind? to determine if there are 4 cards of any rank present. #full_house?, #three_of_a_kind?, and #pair? are all variations on this same theme.

#two_pair? is a variation of #n_of_a_kind? that checks for exactly 2 ranks that are each paired.

One final item of discussion: if you read the testing code closely, you may have noticed that we monkey-patched the Array class to alias the #pop method as #draw. While monkey patching can be dangerous, and should generally be avoided, we do it here so we can test our evaluation methods by treating an Array of Cards as a Deck. Our #initialize method makes use of Card#draw to draw 5 cards, and by aliasing Array#pop as #draw, we are able to use #initialize to draw 5 cards from an Array of Cards.

Further Exploration
The following questions are meant to be thought exercises; rather than write code, think about what you would need to do. Feel free to write some code after thinking about the problem.

How would you modify this class if you wanted the individual classification methods (royal_flush?, straight?, three_of_a_kind?, etc) to be public class methods that work with an Array of 5 cards, e.g.,

Copy Code
def self.royal_flush?(cards)
  ...
end
How would you modify our original solution to choose the best hand between two poker hands?

How would you modify our original solution to choose the best 5-card hand from a 7-card poker hand?