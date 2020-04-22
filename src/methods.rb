module Methods

    #                               ! Presentation Functions !

    # Creates line of specified length
    def line(length)
        puts '-'*length
    end

    # Centers string of text in a line of the length of your choice
    def string_in_line(string, length)
        puts '-'*((length/2)-(string.length/2))+" #{string} "+'-'*((length/2)-(string.length/2))
    end

    
    
end