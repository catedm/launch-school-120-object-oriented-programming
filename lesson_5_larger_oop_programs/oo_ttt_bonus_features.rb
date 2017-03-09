require "pry"

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def square_five_unmarked?
    @squares[5].unmarked?
  end

  def at_risk_square
    WINNING_LINES.each do |line|
      squares = @squares.select { |k, v| k == line[0] || k == line[1] || k == line[2] }
      if two_identical_player_markers?(squares.values)
        return squares.keys.select { |key| squares[key].unmarked? }.last
      end
    end
    nil
  end

  def winning_square
    WINNING_LINES.each do |line|
      squares = @squares.select { |k, v| k == line[0] || k == line[1] || k == line[2] }
      if two_identical_computer_markers?(squares.values)
        return squares.keys.select { |key| squares[key].unmarked? }.last
      end
    end
    nil
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  def joinor(list, delimiter = ', ', word = 'or')
    case list.size
    when 0 then ''
    when 1 then list.first
    when 2 then list.join(" #{word} ")
    else
      "#{list[0..-2].join(delimiter)}#{delimiter}#{word} #{list[-1]}"
    end
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def two_identical_player_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 2
    markers.min == markers.max
  end

  def two_identical_computer_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 2
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  COMPUTER_NAMES = ["Bobby", "Tanya", "James", "Sally"]
  attr_accessor :score, :marker, :name

  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

class TTTGame
  ROUNDS_TO_WIN = 2
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = "choose"

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = nil
  end

  def play
    clear
    display_welcome_message
    set_player_name
    set_computer_name
    pick_marker

    loop do
      FIRST_TO_MOVE == "choose" ? choose_first_to_move : set_first_player
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn?
      end

      calculate_score
      display_result
      display_score
      sleep 2
      break if human.score == ROUNDS_TO_WIN || computer.score == ROUNDS_TO_WIN
      reset
    end

    display_goodbye_message
  end

  private

  def set_player_name
    puts "What's your name?"
    name = ''
    loop do
      name = gets.chomp
      break if name.empty? == false
      puts "Sorry, invaid input."
    end

    human.name = name
  end

  def set_computer_name
    computer.name = Player::COMPUTER_NAMES.sample
    puts "I am your opponent, #{computer.name}."
  end

  def pick_marker
    puts ''
    puts "What character would you like to play as #{human.name}? Pick any one!"
    answer = gets.chomp.to_s
    human.marker = answer
  end

  def set_first_player
    @current_marker = FIRST_TO_MOVE
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_board
    puts ""
    puts "Let's play #{human.name}! You're a #{human.marker}. Computer is a #{computer.marker}."
    puts "The first player to reach #{ROUNDS_TO_WIN} wins!"
    puts ""
    board.draw
    puts ""
  end

  def human_moves
    puts "Choose a square (#{board.joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    if board.winning_square
       board[board.winning_square] = computer.marker
    elsif board.at_risk_square
      board[board.at_risk_square] = computer.marker
    elsif board.square_five_unmarked?
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def choose_first_to_move
    puts "Who would you like to move first? (me/computer)"
    answer = ''
    loop do
      answer = gets.chomp.downcase
      break if answer.start_with?("m") || answer.start_with?("c")
      puts "Sorry, that's not a valid choice."
    end

    @current_marker = HUMAN_MARKER if answer.start_with?("m")
    @current_marker = COMPUTER_MARKER if answer.start_with?("c")
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def calculate_score
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    else
      nil
    end
  end

  def display_score
    case board.winning_marker
    when human.marker
      puts "HUMAN: #{human.score} COMPUTER #{computer.score}"
    when computer.marker
      puts "HUMAN: #{human.score} COMPUTER #{computer.score}"
    else
      nil
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def clear
    system "clear"
  end

  def reset
    board.reset
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
