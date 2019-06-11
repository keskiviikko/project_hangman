
class Game
    attr_reader :the_word

    def initialize
        @the_word = random_word.upcase
        @player_arr = Array.new
        @correct_letters = Array.new
        @wrong_letters = Array.new
        @attempts_left = 10
    end

    def random_word
        @the_word = File.readlines("../5desk.txt").sample.strip()
    end

    def hide_the_word
        @hidden_word = "_" * @the_word.size
    end

    def explain_rules
        puts
        puts "Type any letter A-Z or a word."
        puts "To quit the game type: quitgame"
        puts
        puts "Can you find out this word? #{@hidden_word}"
        puts "Attempts left: #{@attempts_left}/10"
    end

    def player_input
        @player_arr << gets.chomp.upcase
        if @player_arr[-1].empty? #false input
            puts "Type any letter A-Z or a word."
        elsif @player_arr.include?("QUITGAME") #player quits
            puts "You gave up..."
        elsif @correct_letters.include?(@player_arr[-1]) #correct guess
            puts "You've already tried that..."
        elsif @the_word.include?(@player_arr[-1]) #correct guess
            puts "Nice!"
        elsif @wrong_letters.include?(@player_arr[-1]) #wrong guess
            puts "You've already tried that..."
        else #wrong guess
            @attempts_left -= 1
            puts "That's not it!"
        end
    end

    def update_attempts_left
        puts "Attempts left: #{@attempts_left}/10"
    end

    def update_correct_letters
        if @the_word.include?(@player_arr[-1])
            @correct_letters << @player_arr[-1] unless @correct_letters.include?(@player_arr[-1])
        end
    end

    def update_wrong_letters
        if !@the_word.include?(@player_arr[-1])
            @wrong_letters << @player_arr[-1] unless @wrong_letters.include?(@player_arr[-1])
        end
        puts "Wrong letters: #{@wrong_letters}"
    end

    def update_hidden_word
        if @the_word.chars.any? do |letter|
            @player_arr.include?(letter.upcase)
            end
            puts @hidden_word = @the_word.chars.map { |c| @player_arr.include?(c) ? c : '_' }.join
        else
            puts @hidden_word
        end
    end

    def has_won?
        if !@hidden_word.include?("_") || @player_arr.include?(@the_word.upcase)
            puts "You won!!"
            puts "The word is #{@the_word}"
        elsif @attempts_left == 0
            puts "You lost..."
            puts "The word is #{@the_word}"
        end
    end

    def game_round
        puts
        puts "Let's play hangman!"
        hide_the_word
        explain_rules
        while @attempts_left > 0
            puts
            print "Enter your guess: "
            player_input
            break if @player_arr.include?("QUITGAME")
            update_attempts_left
            update_correct_letters
            update_wrong_letters
            break if @player_arr.include?(@the_word.upcase)
            update_hidden_word
            break if !@hidden_word.include?("_")
        end
        has_won?
    end

    def save

    end

    def load

    end

end


new_game = Game.new
new_game.game_round