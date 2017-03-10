require "pry"

module Hand

  def busted?
    total > 21
  end

  def total
    values = @cards.map { |cards| cards[0] }

    sum = 0
    values.each do |value|
      if value == "Ace"
        sum += 11
      elsif value.to_i == 0
        sum += 10
      else
        sum += value.to_i
      end
    end

    values.select { |value| value == "Ace" }.count.times do
      sum -= 10 if sum > 21
    end

    sum
  end

end

class Player
  include Hand
  attr_accessor :cards

  def initialize
    @cards = cards
  end
end

class Dealer
  include Hand
  attr_accessor :cards

  def initialize
    @cards = cards
  end
end

class Deck
  SUITS = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

  attr_accessor :deck

  def initialize
    @deck = VALUES.product(SUITS).shuffle
  end

  def deal
    deck.pop(2)
  end

  def hit
    deck.pop(1)
  end
end

class Game

  attr_reader :player, :dealer, :deck

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    loop do
      system "cls"
      display_welcome_message
        loop do
          deal_cards
          display_intial_cards
          player_turn
          break if player.busted?
          dealer_turn
          determine_winner
          display_winner
          break unless play_again?
        end

      if player.busted?
        determine_winner
        display_winner
        break unless play_again?
      end

      break
    end

      display_goodbye_message
  end

  private

  def message_lines
    puts "==============================="
  end

  def display_welcome_message
    puts ""
    message_lines
    puts "Welcome to TWENTY-ONE!"
    message_lines
    puts ""
  end

  def display_goodbye_message
    message_lines
    puts "Thank you for playing!"
    puts "Goodbye!"
    message_lines
  end

  def play_again?
    choice = nil
    loop do
      puts "Would you like to play again? (y/n)"
      choice = gets.chomp.downcase
      break if choice == "y" || choice == "n"
      puts "Must choose 'y' or 'n'."
    end

    return false if choice == "n"
    return true if choice == "y"
  end

  def player_bust?
    if player.busted?
      puts "You BUSTED!"
      determine_winner
      return display_winner
    end
  end

  def deal_cards
    puts "DEALING..."
    sleep 1
    player.cards = deck.deal
    dealer.cards = deck.deal
  end

  def dealer_turn
    puts "Dealer's turn..."
    sleep 2
    until dealer.total >= 17
      puts "The dealer hit..."
      sleep 2
      dealer.cards << deck.hit[0]
    end

    dealer.busted? ? puts("The dealer BUSTED!") : puts("The dealer stayed at #{dealer.total}")
  end

  def player_turn
    puts ""
    puts "It's your turn!"

    loop do
    choice = nil
      loop do
        puts "Would you like to hit or stay? (h/s)"
        choice = gets.chomp
        break if ['h', 's'].include?(choice)
        puts "Sorry, must enter 'h' or 's'."
      end

      if choice == "h"
        player.cards << deck.hit[0]
        puts "You chose to hit!"
        sleep 1
        display_player_cards
        player.busted? ? puts("You BUSTED!") : nil
      else choice == "s"
        puts "You stayed at #{player.total}"
      end

      break if choice == "s" || player.busted?
    end
  end

  def format_player_card_display(hand)
    result = ""
    hand.each { |card| result += "#{card[0] + " of " + card[1]}, " }
    result[0..-3]
  end

  def format_dealer_card_display_hidden(hand)
    "#{hand[0][0]} of #{hand[0][1]} and ?"
  end

  def display_player_cards
    puts "Your cards are now: " + format_player_card_display(player.cards) + " for a total of #{player.total}"
  end

  def display_intial_cards
    puts "Your cards: " + format_player_card_display(player.cards) + " for a total of #{player.total}"
    puts "Dealer cards: " + format_dealer_card_display_hidden(dealer.cards)
  end

  def display_final_cards
    puts "Your cards: " + format_player_card_display(player.cards) + " for a total of #{player.total}"
    puts "Dealer cards: " + format_player_card_display(dealer.cards) + " for a total of #{dealer.total}"
  end

  def determine_winner
    if player.busted?
      :player_busted
    elsif dealer.busted?
      :dealer_busted
    elsif player.total > dealer.total
      :player_wins
    elsif player.total < dealer.total
      :dealer_wins
    else player.total == dealer.total
      :tie
    end
  end

  def display_winner
    puts ""
    puts "RESULTS:"
    display_final_cards
    puts ""
    case determine_winner
    when :player_busted then puts "You BUSTED! The dealer wins."
    when :dealer_busted then puts "Dealer BUSTED! You win."
    when :dealer_wins then puts "The dealer won the round."
    when :player_wins then puts "You won the round."
    when :tie then puts "It's a tie!"
    end
  end
end

Game.new.start
