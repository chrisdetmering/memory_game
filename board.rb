
require_relative "card"

class Board 

    DECK = ['K','K','Q','Q','J','J','L','L',
             'P','P','T','T','A','A','B','B']
    attr_reader :grid

    def initialize 
        @grid = Array.new(4) {[]}
        @deck = DECK
    end 

    def populate 
        shuffled_deck = DECK.shuffle 
        
        shuffled_deck.each_with_index do |card, index|

            if index < 4
                @grid[0] << Card.new(card)

            elsif (index >= 4) && (index < 8)
                @grid[1] << Card.new(card)

            elsif (index >=8) && (index < 12)
                @grid[2] << Card.new(card)

            else 
                @grid[3] << Card.new(card)
            end 
        end 
        
    end 


    def display_grid
        system('clear')

         new_grid_with_flipped_cards = []

        @grid.each do |row| 
            flipped_or_not = []

            row.each.with_index do |card, index| 

                if card.face_down
                    flipped_or_not << " "
                else
                    flipped_or_not << card.face_value
                end

                if index == 3 
                    new_grid_with_flipped_cards << flipped_or_not
                    flipped_or_not = []
                end 
            end 
        end 


        puts "  0 1 2 3"
        puts "0 #{new_grid_with_flipped_cards[0].map(&:to_s).join(" ")}"
        puts "1 #{new_grid_with_flipped_cards[1].map(&:to_s).join(" ")}"    
        puts "2 #{new_grid_with_flipped_cards[2].map(&:to_s).join(" ")}"   
        puts "3 #{new_grid_with_flipped_cards[3].map(&:to_s).join(" ")}"    
    end 


    def [](position)

        self.grid[position[0]][position[1]]
    end 


    def reveal(guessed_pos) 
        
        x = guessed_pos[0]
        y = guessed_pos[1]

        choosen_card = @grid[x][y]

            if choosen_card.face_down

                choosen_card.reveal
            else
                
                choosen_card.reveal
            end

        return choosen_card.face_value
    end 

    def hide(guessed_pos)
        x = guessed_pos[0]
        y = guessed_pos[1]

        choosen_card = @grid[x][y]
        choosen_card.hide
    end 

end 

