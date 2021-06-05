class Card
  attr_accessor :rank, :suit, :color
  def initialize(rank, suit, color)
    @rank = rank
    @suit = suit
    @color = color
  end

  def view_card
    puts "the #{self.rank} of #{self.suit} (#{self.color})"
  end
end


class Deck
  attr_accessor :cards
  def initialize
    @ranks = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
    @suits = %w(Spades Diamonds Clubs Hearts)
    @cards = []
    generate_deck
  end

  def shuffle_cards
    @cards.shuffle!
  end

  def generate_deck
    @suits.each do |suit|
      @ranks.size.times do |i|
        color = (suit == 'Spades' || suit == 'Clubs') ? 'Black' : 'Red'
        @cards << Card.new(@ranks[i], suit, color)
      end
    end
  end

  def deal_card
    face_up_card = @cards.pop
    return "#{face_up_card.rank} of #{face_up_card.suit} (#{face_up_card.color})"
  end

  def display_cards
    @cards.shuffle.each do |card|
      puts "#{card.rank} #{card.suit} (#{card.color})"
    end
  end
end
