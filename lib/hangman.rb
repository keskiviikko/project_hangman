
class Game
    attr_reader :the_word

    def initialize
        @the_word = random_word.upcase
        @player_input = String.new
        @attempts_left = 10
    end

    def random_word
        @the_word = File.readlines("../5desk.txt").sample
    end

    def hide_the_word
        
    end

    def update #change all of this
        puts @hidden_word
        puts @the_word
    end

    def guess_a_letter
        @player_input << gets.chomp
        puts "All the letters you have guessed: #{@player_input}"
    end

    def save

    end

    def load

    end
    
    def has_won?
        if @player_input.include?("w") #change this
            puts "You won!"
        elsif @attempts_left == 0
            puts "You lost..."
        end
    end

    def game_round
        hide_the_word
        while @attempts_left > 0
            guess_a_letter
            update
            @attempts_left -= 1
            has_won?
            break if @player_input.include?("q") #delete this
        end
    end

end


new_game = Game.new
new_game.game_round