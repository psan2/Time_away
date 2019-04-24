class Vacation
    def initialize(name, day, holiday)
        @name = name
        @day = Date.strptime(day,"%d/%m/%Y")
        @holiday = holiday
        if @day == saturday? || @day == sunday?
            @weekend = true
        else
            @weekend = false
        
    end


end
