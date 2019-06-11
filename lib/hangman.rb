
class Game
    attr_reader :the_word

    def initialize
        @the_word = random_word.upcase
        @player_input = Array.new
        @wrong_letters = Array.new
        @attempts_left = 10
    end

    def random_word
        @the_word = File.readlines("../5desk.txt").sample.strip()
    end

    def hide_the_word
        @hidden_word = "_" * @the_word.size
        puts @the_word #delete this!
    end

    def explain_rules
        puts
        puts "Type any letter A-Z or a word."
        puts "To quit the game type: quitgame"
        puts
        puts "Can you find out this word? #{@hidden_word}"
        puts "You have #{@attempts_left} attempts left."
    end

    def update_hidden_word
        if @the_word.chars.any? do |letter|
            @player_input.include?(letter.upcase)
            end
            puts @hidden_word = @the_word.chars.map { |c| @player_input.include?(c) ? c : '_' }.join
        else
            puts @hidden_word
        end
    end

    def update_player_input
        @player_input << gets.chomp.upcase
        if @player_input.include?("QUITGAME")
            puts "You gave up..."
        elsif @the_word.include?(@player_input[-1])
            puts "You have #{@attempts_left} attempts left."
        elsif @wrong_letters.include?(@player_input[-1])
            puts "You've already tried that..."
            puts "You have #{@attempts_left} attempts left."
        else
            @attempts_left -= 1
            puts "That's not it!"
            puts "You have #{@attempts_left} attempts left."
        end
    end

    def update_wrong_letters
        if !@the_word.include?(@player_input[-1])
            @wrong_letters << @player_input[-1] unless @wrong_letters.include?(@player_input[-1])
        end
        puts "All the wrong letters you have guessed: #{@wrong_letters}"
    end

    def has_won?
        if !@hidden_word.include?("_") || @player_input.include?(@the_word.upcase)
            puts "You won!"
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
            update_player_input
            break if @player_input.include?("QUITGAME")
            update_wrong_letters
            update_hidden_word
            has_won?
            break if !@hidden_word.include?("_") ||
                    @player_input.include?(@the_word.upcase)
        end
    end

    def save

    end

    def load

    end

end


new_game = Game.new
new_game.game_round