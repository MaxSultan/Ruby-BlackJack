require_relative 'cards'
require_relative 'player'

def end_game(dealer, player)
  dealer.calculate_hand_value
  player.calculate_hand_value
  if player.hand_value > dealer.hand_value
    puts "you win! Your bet was $#{@bet}"
    player.win(@bet)
    continue(player, dealer)
  else
    puts "you lose. you lose $#{@bet}"
    player.lose(@bet)
    if player.cash <= 0
      puts "You are out of money. Thanks for playing!"
      exit
    else
    continue(player, dealer)
    end
  end
end

def dealer_hits(dealer, player, deck)
  dealer.recieve_card(deck.deal_card)
  dealer.display_hand
  dealer.calculate_hand_value
  if dealer.hand_value <= 16
    puts "the dealer hits"
   dealer_hits(dealer, player, deck)
  elsif dealer.hand_value > 21
    puts "the dealer busts. You win $#{@bet}"
    player.win(@bet)
    continue(player, dealer)
  else
    end_game(dealer, player)
    continue(player, dealer)
  end
end

def hit_stay(player, dealer, deck)
  puts "would you like to hit or stay?"
  puts "1) hit (get another card)"
  puts "2) stay (keep your cards the way they are)"
  print '> '
  decision = gets.chomp.to_i
  case decision
  when 1
    puts "you recieve a card"
    player.recieve_card(deck.deal_card)
    puts "your hand is now:"
    player.display_hand
    player.calculate_hand_value
    if player.hand_value > 21
      puts "you busted. you lose $#{@bet}"
      player.lose(@bet)
      continue(player, dealer)
    else
    hit_stay(player, dealer, deck)
    end
  when 2
    puts "the dealers bottom card is revealed"
    puts "the dealers hand is:"
    dealer.turn(deck.deal_card)
    dealer.display_hand
    if dealer.hand_value <= 16
      puts 'the dealer hits'
      dealer_hits(dealer, player, deck)
    else
    end_game(dealer, player)
    end
  end
end

def continue(player, dealer)
  puts "would you like to play again?"
  print '>'
  play_array = ['yes', 'y', 'ok','sure']
  play_again = gets.chomp.to_s
  if play_array.include?(play_again)
    player.reset
    dealer.reset
    play_blackjack(player, dealer)
  else
    puts "Thanks for playing. Goodbye"
    exit
  end
end

def play_blackjack(player, dealer)
  puts "The game is blackjack, lets get started"
  puts "you have $#{player.cash}"
  puts "What would you like to bet?"
  @bet = gets.chomp.to_i

  deck = Deck.new
  deck.shuffle_cards
  puts "You are delt"
  player.turn(deck.deal_card)
  player.turn(deck.deal_card)
  player.display_hand
  puts "the dealers face up card is "
  dealer.turn(deck.deal_card)
  dealer.display_hand
  if player.hand_value == 21
    dealer.turn(deck.deal_card)
    if player.hand_value == 21 && dealer.hand_value == 21
      puts "both players have 21. Push!"
    else
      puts "BLACKJACK!!!"
      player.blackjack(@bet)
    end
  else
    hit_stay(player, dealer, deck)
  end
end

dealer = Player.new('dealer', 10000000000000000)
puts "Welcome to the casino"
puts "What is your name?"
print '>'
name = gets.chomp.to_s
puts "How much money did you bring to play with today?"
print '>'
cash = gets.chomp.to_i
player = Player.new(name, cash)

play_blackjack(player, dealer)
end_game(dealer, player)
continue(player, dealer)

#there is an issue with bet being set. because of this none of the money amounts
# change in the game
