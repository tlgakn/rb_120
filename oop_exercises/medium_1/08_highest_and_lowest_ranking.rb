Highest and Lowest Ranking Cards
Update this class so you can use it to determine the lowest ranking and highest ranking cards in an Array of Card objects:

Copy Code
class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end
For this exercise, numeric cards are low cards, ordered from 2 through 10. Jacks are higher than 10s, Queens are higher than Jacks, Kings are higher than Queens, and Aces are higher than Kings. The suit plays no part in the relative ranking of cards.

If you have two or more cards of the same rank in your list, your min and max methods should return one of the matching cards; it doesnt matter which one.

Besides any methods needed to determine the lowest and highest cards, create a #to_s method that returns a String representation of the card, e.g., "Jack of Diamonds", "4 of Clubs", etc.

Examples:
cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8

Output:
2 of Hearts
10 of Diamonds
Ace of Clubs
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

Approach/Algorithm
This exercise doesn/t expect you to define a #min or #max method in the Card class. It wants you to update the class so that Enumerable#min and Enumerable#max work when applied to an Array of Card objects.

Hint
Investigate the Comparable module.


Solution
Copy Code
class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end
Discussion
Enumerable#min and Enumerable#max work with objects whose classes mix-in the Comparable module, which means the class must provide a #<=> method.

Our solution does that: it includes the Comparable module, and implements #<=>. The method obtains the values of each card with #value, and then compares them using Integer#<=>.

#value uses Hash#fetch to convert named ranks (Jack, Queen, King, Ace) to appropriate values, and uses the numeric value for numbered cards (2-10) as the value.

Further Exploration
You will need the original exercise solution for the next two exercises. If you work on this Further Exploration, keep a copy of your original solution so you can reuse it.

Assume you/re playing a game in which cards of the same rank are unequal. In such a game, each suit also has a ranking. Suppose that, in this game, a 4 of Spades outranks a 4 of Hearts which outranks a 4 of Clubs which outranks a 4 of Diamonds. A 5 of Diamonds, though, outranks a 4 of Spades since we compare ranks first. Update the Card class so that #min and #max pick the card of the appropriate suit if two or more cards of the same rank are present in the Array.


# Further Exploration, Student Solution
class Card
  SUIT_RANKS = {"Diamonds" => 1, "Clubs" => 2, "Hearts" => 3, "Spades" => 4} # FURTHER EXPLORATION

  attr_reader :rank, :suit, :value

  include Comparable

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = find_value
  end

  def find_value
    value = case rank
            when "Ace" then 14
            when "King" then 13
            when "Queen" then 12
            when "Jack" then 11
            else rank 
            end
    value
  end

  def <=>(other)
    if rank == other.rank # FURTHER EXPLORATION
      SUIT_RANKS[suit] <=> SUIT_RANKS[other.suit]
    else
      value <=> other.value
    end
  end

  def to_s
    "#{rank} of #{suit}"
  end
end