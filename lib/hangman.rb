require 'yaml'

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
        puts "Let's play hangman!"
        puts
        puts "To save the game type: savegame"
        puts "To load a previous save type: loadgame"
        puts "To quit the game type: quitgame"
        puts
        if @player_arr.include?("SAVEGAME")
            print "Can you find out this word? "
            update_hidden_word
        else
            puts "Can you find out this word? #{@hidden_word}"
        end
        puts "Type any letter A-Z or a word."
        puts "Attempts left: #{@attempts_left}/10"
    end

    def player_input
        @player_arr << gets.chomp.upcase
        if @player_arr[-1].empty? #blank input
            puts "Type any letter A-Z or a word."
        elsif @player_arr[-1] == "SAVEGAME" #player saves
            save
        elsif @player_arr[-1] == "LOADGAME" #loads previous save
            load
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

    def show_attempts_left
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
        hide_the_word
        explain_rules
        while @attempts_left > 0
            puts
            print "Enter your guess: "
            player_input
            break if @player_arr.include?("QUITGAME")
            show_attempts_left
            update_correct_letters
            update_wrong_letters
            break if @player_arr.include?(@the_word.upcase)
            update_hidden_word
            break if !@hidden_word.include?("_")
        end
        has_won?
    end

    def save
        game_data = {
            the_word: @the_word,
            hidden_word: @hidden_word,
            player_arr: @player_arr,
            correct_letters: @correct_letters,
            wrong_letters: @wrong_letters,
            attempts_left: @attempts_left
        }

        Dir.mkdir("saves") unless Dir.exists? "saves"

        puts "WARNING! If the filename already exist that data will be overwritten!"
        print "Enter a filename for your save: "
        filename = gets.chomp

        File.open("saves/#{filename}.yaml", "w") do |file|
            file.puts game_data.to_yaml
        end
        puts "Game saved."
    end

    def load
        filename = nil
        loop do
            print "Please enter the filename: "
            filename = gets.chomp
            break if File.exists? "saves/#{filename}.yaml"
        end
        
        game_data = YAML.load_file("saves/#{filename}.yaml")
        
        @the_word = game_data[:the_word]
        @hidden_word = game_data[:hidden_word]
        @player_arr = game_data[:player_arr]
        @correct_letters = game_data[:correct_letters]
        @wrong_letters = game_data[:wrong_letters]
        @attempts_left = game_data[:attempts_left]
        
        game_round
    end
end


new_game = Game.new
new_game.game_round