class TurnosController < ApplicationController
    def index
        @vaccines = Vaccine.all
    end

    
end
