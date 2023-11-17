class Mastermind
    COLORS = %w(R G B Y O P)
  
    def initialize
      @turns = 12
      @code_length = 4
    end
  
    def play
      puts "Welcome to Mastermind!"
  
      choose_role
  
      if @role == 'creator'
        generate_secret_code
      else
        human_guessing
      end
    end
  
    private
  
    def choose_role
      puts "Do you want to be the creator or guesser of the secret code? (creator/guesser)"
      @role = gets.chomp.downcase
      until %w(creator guesser).include?(@role)
        puts "Invalid input. Please enter 'creator' or 'guesser'."
        @role = gets.chomp.downcase
      end
    end
  
    def generate_secret_code
      @secret_code = Array.new(@code_length) { COLORS.sample }
      computer_guessing
    end
  
    def human_guessing
      puts "Guess the secret code using the first letters of colors (e.g., RGBY):"
      until @turns.zero?
        guess = gets.chomp.upcase
        if valid_guess?(guess)
          feedback = provide_feedback(guess)
          display_feedback(feedback)
          break if guess == @secret_code.join
          @turns -= 1
          puts "Turns left: #{@turns}"
        else
          puts "Invalid guess. Please enter a valid combination of colors."
        end
      end
      end_game
    end
  
    def computer_guessing
      puts "The computer will now try to guess your secret code."
  
      until @turns.zero?
        computer_guess = Array.new(@code_length) { COLORS.sample }
        puts "Computer's guess: #{computer_guess.join}"
        feedback = provide_feedback(computer_guess)
        display_feedback(feedback)
        break if feedback == ['B'] * @code_length
        @turns -= 1
        puts "Turns left: #{@turns}"
      end
  
      end_game
    end
  
    def valid_guess?(guess)
      guess.match?(/^[RGBYOP]{#{@code_length}}$/)
    end
  
    def provide_feedback(guess)
      feedback = []
      guess.each_with_index do |color, index|
        if color == @secret_code[index]
          feedback << 'B'
        elsif @secret_code.include?(color)
          feedback << 'W'
        end
      end
      feedback.sort
    end
  
    def display_feedback(feedback)
      puts "Feedback: #{feedback.join}"
    end
  
    def end_game
      if @role == 'creator'
        puts "The secret code was: #{@secret_code.join}"
      else
        puts @turns.zero? ? "You ran out of turns! The secret code was: #{@secret_code.join}" : "Congratulations! You guessed the secret code!"
      end
    end
  end
  
  # Uncomment the next two lines to play the game
mastermind_game = Mastermind.new
mastermind_game.play
  