class PingGame
  def initialize(low, high)
    @low = low
    @high = high
    @amnt_of_guesses = Math.log2(@high - @low).to_i + 1
    @guess = nil
    @answer = (low..high).to_a.sample
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
      puts "Enter a number between #{@low} and #{@high}:"
      @guess = gets.chomp.to_i
      break if @guess == @answer || @guess.between?(@low, @high)
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

game = PingGame.new(100, 9040)
game.play
