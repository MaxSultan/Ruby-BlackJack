class Player
  attr_accessor :name, :hand, :bet
  attr_reader :cash
  def initialize(name, cash)
    @name = name
    @cash = cash
    @bet = 0
    @hand = []
    @hand_value = 0
  end

  def reset
    @hand = []
    @hand_value = 0
  end

  def win(bet)
    @cash = @cash + bet
  end

  def lose(bet)
    @cash = @cash - bet
  end

  def blackjack(bet)
    @cash = @cash + 1.5 * bet
  end

  def display_hand
    @hand.each do |card|
      puts card
    end
  end

  def recieve_card(card)
    @hand.push(card)
  end

  def calculate_hand_value
    @hand_value = 0
    rank_array = @hand.map do |card|
      rank = card.split(//).first
      case rank
      when '2'
        @hand_value = @hand_value + 2
      when '3'
        @hand_value = @hand_value + 3
      when '4'
        @hand_value = @hand_value + 4
      when '5'
        @hand_value = @hand_value + 5
      when '6'
        @hand_value = @hand_value + 6
      when '7'
        @hand_value = @hand_value + 7
      when '8'
        @hand_value = @hand_value + 8
      when '9'
        @hand_value = @hand_value + 9
      when '1'
        @hand_value = @hand_value + 10
      when 'J'
        @hand_value = @hand_value + 10
      when 'Q'
        @hand_value = @hand_value + 10
      when 'K'
        @hand_value = @hand_value + 10
      when 'A'
        if @hand_value <= 10
          @hand_value = @hand_value + 11
        else
          @hand_value = @hand_value + 1
        end
      end
    end
  end

  def hand_value
    @hand_value
  end

  def turn(card)
    self.recieve_card(card)
    self.calculate_hand_value
  end 

end
