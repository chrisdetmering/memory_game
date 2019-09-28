require_relative "board"
require_relative "card"
require_relative "player"


class Game 

    attr_reader :board, :first_guess_coord, :second_guess_coord

    def initialize 
        @board = Board.new
        @player = Player.new
        @first_guess_coord = nil
        @second_guess_coord = nil
    end 


    def play 
        @board.populate

        until game_over? 
            @board.display_grid
            first_guess

            @board.display_grid
            second_guess

            @board.reveal(@second_guess_coord)
            @board.display_grid

            if !check_guesses 
                @board.hide(@first_guess_coord)
                @board.hide(@second_guess_coord)
                puts "Try again!"
                sleep(2)

            else 
                @board.display_grid

                @player.receive_match(@first_guess_coord, @second_guess_coord)
                @player.known_cards.delete(@first_guess_coord)
                @player.known_cards.delete(@second_guess_coord)

                puts "That's a match!"
                sleep(1)
            end
           
        end
        
        system('clear')
        puts "YOU WON!"
    end


    def coordinates(coordinates_string)
        coordinates = coordinates_string.split(",")

        x = coordinates[0].to_i
        y = coordinates[1].to_i

        return [x, y]
    end 


    def first_guess

        @first_guess_coord = coordinates(@player.guess)
        value = @board.reveal(@first_guess_coord)
       
    
        @player.receive_revealed_card(@first_guess_coord, value) 
        
    end 


    def second_guess
        
        second_guess_attempt = @player.guess

        if coordinates(second_guess_attempt) == @first_guess_coord
            system('clear')
            puts "You already guessed that position"
            sleep(2)
            system('clear')
            @board.display_grid

            second_guess
        else 

            @second_guess_coord = coordinates(second_guess_attempt)

            value = @board.reveal(@second_guess_coord)
       
    
            @player.receive_revealed_card(@second_guess_coord, value) 
        end 

    end 


    def check_guesses 
        card1 = @board[@first_guess_coord]
        card2 = @board[@second_guess_coord]

        card1 == card2
    end 


    def game_over?
        
        @board.grid.each do |row| 
            row.each do |card| 
                if card.face_down 
                    return false                 
                end
            end 
        end 

        return true
    end 

end 


if $PROGRAM_NAME == __FILE__
    my_game = Game.new 

    my_game.play
end


