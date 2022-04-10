class EstadisticosController < ApplicationController
  def new
    @vacunadores = User.where(rol: "Vacunador")
    @vacunas =Vaccine.all
  end
  def edit
  @vacunas =Vaccine.all
  @vacunatorios =Vaccination.all
  end

  def todos
  end

  def vacunas
    @vacunas =Vaccine.all
  end
end
