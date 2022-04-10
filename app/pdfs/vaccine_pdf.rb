class VaccinePdf < Prawn::Document
    def inicialize(vacuna)
        super
        text "Probando"
    end
end