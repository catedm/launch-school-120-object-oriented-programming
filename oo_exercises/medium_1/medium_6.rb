class PingGame
  GUESS_AMOUNT = 7

  def initialize
    @amnt_of_guesses = GUESS_AMOUNT
    @guess = nil
    @answer = (1..100).to_a.sample
  end

  def play
    loop do
      display_guesses_remaining
      guess
      break if guess_correct? || out_of_guesses?
    end

    guess_correct? ? puts("You win!") : puts("You are out of guesses. You lose.")
  end

  def display_guesses_remaining
    puts "You have #{@amnt_of_guesses} guesses remaining."
  end

  def guess
    loop do
      puts "Enter a number between 1 and 100:"
      @guess = gets.chomp.to_i
      break if @guess == @answer || @guess.between?(1, 100)
      puts "Invalid guess."
    end

    if @guess < @answer
      puts "Your guess is too low."
      puts ""
      @amnt_of_guesses -= 1
    else @guess > @answer
      puts "Your guess is too high"
      puts ""
      @amnt_of_guesses -= 1
    end
  end

  def out_of_guesses?
    @amnt_of_guesses == 0
  end

  def guess_correct?
    @guess == @answer
  end
end

game = PingGame.new
game.play
