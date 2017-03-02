POINTS_TO_WIN = 3

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  HAL_CHOICES = ['scissors', 'lizard', 'spock']
  R2D2_CHOICES = ['rock', 'paper']

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

  def >(other_move)
    (spock? && other_move.rock?) ||
      (paper? && other_move.spock?) ||
      (lizard? && other_move.paper?) ||
      (scissors? && other_move.lizard?) ||
      (spock? && other_move.scissors?) ||
      (lizard? && other_move.spock?) ||
      (rock? && other_move.lizard?) ||
      (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.spock?) ||
      (spock? && other_move.paper?) ||
      (paper? && other_move.lizard?) ||
      (lizard? && other_move.scissors?) ||
      (scissors? && other_move.spock?) ||
      (spock? && other_move.lizard?) ||
      (lizard? && other_move.rock?) ||
      (scissors? && other_move.rock?) ||
      (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score, :won_or_lost_history, :message
  attr_reader :move_history

  def initialize
    @score = 0
    @move_history = []
    @won_or_lost_history = []
    @message = ''
    set_name
  end
end

class Human < Player
  def set_name
    n = ''
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
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
    @move_history << Move.new(choice).to_s
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Charlie'].sample
  end

  def choose
    if name == "Hal"
      self.move = Move.new(Move::HAL_CHOICES.sample)
    elsif name == "R2D2"
      self.move = Move.new(Move::R2D2_CHOICES.sample)
    else
      self.move = Move.new(Move::VALUES.sample)
    end
    @move_history << move.to_s
  end

  def message
    if name == 'R2D2'
      self.message = 'Beep! Bop bop!'
    elsif name == "Hal"
      self.message = "I'm a HUGE Star Treck fan."
    else
      self.message = "I'am always the smartest man in the room."
    end
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock #{human.name}!"
    puts "The first player to #{POINTS_TO_WIN} wins."
  end

  def display_opponent_message
    puts "Your opponent is #{computer.name} - '#{computer.message}'"
  end

  def display_goodbye_message
    if computer.score == POINTS_TO_WIN
      puts "#{computer.name} WINS"
    else
      puts "YOU WIN"
    end
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def build_move_history
    if human.move > computer.move
      human.won_or_lost_history << "WON"
    elsif human.move < computer.move
      human.won_or_lost_history << "LOST"
    else
      human.won_or_lost_history << "TIED"
    end
  end

  def calculate_score
    if human.move > computer.move
      human.score += 1
    else
      computer.score += 1
    end
  end

  def display_score
    puts " "
    puts "--------------------------------"
    puts "#{human.name} has #{human.score} points."
    puts "#{computer.name} has #{computer.score} points."
    puts "--------------------------------"
    puts " "
  end

  def display_move_history
    rounds = human.move_history.zip(computer.move_history)
    rounds.each_with_index do |round, idx|
      puts "ROUND #{idx + 1}: #{round.first} vs #{round.last}: YOU" + " #{human.won_or_lost_history[idx]}"
    end
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer)
      puts "Sorry, must be valid input"
    end

    return true if answer == 'y'
    false
  end

  def play
    display_welcome_message
    display_opponent_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      build_move_history
      calculate_score
      display_score
      break if human.score == POINTS_TO_WIN || computer.score == POINTS_TO_WIN
    end
    display_goodbye_message
    puts ''
    display_move_history
  end
end

RPSGame.new.play
# player1 = Human.new
# puts player1.score
