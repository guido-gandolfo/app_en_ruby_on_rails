class VaccinePdf < Prawn::Document
    attr_accessor :path

    PDF_OPTIONS = {
      :page_size   => "A5",
      :page_layout => :landscape,
      # :background  => "public/images/cert_bg.png",
      :margin      => [40, 75]
    }
    def inicialize(path = nil)
        super(top_margin: 70)
        @vaccine = vaccine
        text "Vacuna de #{@vaccine.nombre_vacuna}"
    end





end