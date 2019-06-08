
class Game
    attr_reader :the_word

    def initialize
        @the_word = random_word.upcase
        @player_input = Array.new
        @attempts_left = 10
    end

    def random_word
        @the_word = File.readlines("../5desk.txt").sample.strip()
    end

    def hide_the_word
        @hidden_word = "_" * @the_word.size
        puts "Can you find out this word? #{@hidden_word}"
        puts "You have #{@attempts_left} attempts left."
        puts @the_word #delete this
    end

    def update
        if @the_word.chars.any? {|letter| @player_input.include?(letter.downcase)}
            puts "updated hidden word" #change this
        elsif
            puts @hidden_word
        end
        puts "You have #{@attempts_left-1} attempts left."
    end

    def guess_a_letter
        @player_input << gets.chomp
        puts "All the letters you have guessed: #{@player_input}"
    end
    
    def has_won?
        if !@hidden_word.include?("_") || @player_input.include?(@the_word.downcase)
            puts "You won!"
        elsif @attempts_left == 0
            puts "You lost..."
        end
    end

    def game_round
        puts "Let's play hangman!"
        hide_the_word
        while @attempts_left > 0
            guess_a_letter
            update
            @attempts_left -= 1
            has_won?
            break if @player_input.include?("q") #delete this
        end
    end

    def save

    end

    def load

    end

end


new_game = Game.new
new_game.game_round