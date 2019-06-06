
class Game
    attr_reader :word

    def initialize
        @word = File.readlines("../5desk.txt").sample
        @guessed_letters = String.new
        @attempts_left = 10
    end

    def censor
        
    end

    def show_guessed_letters
        puts @word
    end

    def guess_a_letter
        @guessed_letters << gets.chomp
        puts @guessed_letters
    end

    def save

    end

    def load

    end
    
    def has_won?
        @guessed_letters == @word.to_s
    end

    def game_round
        while @attempts_left > 0
            show_guessed_letters
            guess_a_letter
            @attempts_left -= 1
            if has_won?
                puts "You won!"
                return
            end
            break if @guessed_letters.include?("q")
        end
    end

end


new_game = Game.new
new_game.game_round