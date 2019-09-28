

class Player 

    attr_reader :known_cards, :matched_cards

    def initialize 
        @known_cards = {} #position & value 
        @matched_cards = [] #[positon1, position2]
        @last_guess = nil
    end 


    def prompt
        puts "Please, enter a position you would like to flop (e.g. ‘2,3’)"

        position = gets.chomp

       return position
    end

    def receive_revealed_card(position, value) 
        @known_cards[position] = value
    end 

    def receive_match(position1, position2)
        @matched_cards << position1.join(",")
        @matched_cards << position2.join(",")
    end 

    def matching_cards_in_known_cards
        values = @known_cards.values 

        (0...values.length - 1).each do |i| 
            (i + 1...values.length).each do |j|
                if values[i] == values[j]
                    return @known_cards.key(values[i])
                end
            end 
        end 

        false
    end 


    def guess 

       
        if @known_cards.has_value?(@last_guess)

            matched_guess = @known_cards.key(@last_guess)
            @last_guess = nil

            return matched_guess.join(",")

        elsif matching_cards_in_known_cards 

            matched_guess = matching_cards_in_known_cards 
            @last_guess = @known_cards.delete(matching_cards_in_known_cards)

            return matched_guess.join(",")
        else 

            random_guess = "#{rand(0..3)},#{rand(0..3)}"


            if @matched_cards.include?(random_guess)

                guess
            else 

                return random_guess
            end 
        end 



    end 


end 

