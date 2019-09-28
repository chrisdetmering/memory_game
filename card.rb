class Card 
    
    attr_reader :face_value, :face_down
    
    def initialize(face_value)
        @face_value = face_value
        @face_up = false 
        @face_down = true
    end 

    
    def hide
        @face_down = true 
        @face_up = false 
    end 

    def reveal 
        @face_down = false 
        @face_up = true 
    end 

    def ==(card)
        self.face_value == card.face_value
    end 

end 

