class VaccinatorsController < ApplicationController
  def listar
     @vacunas =Vaccine.all
  end

  # GET /vaccinators/new
  def new
    @vaccinator= Vaccinator.new
  end

  def asignar
    if(params[:estado] == "Atendido")
      @vaccine = Vaccine.find(params[:format])
      @vaccine.estado = "Atendido"
      redirect_to new_cargarvacuna(@vaccine)
      @vaccine.save
    end
    if(params[:estado] == "Pendiente")
      @vacunas = Vaccine.where(fecha_aplicacion: Date.today, lugar_act: current_user.lugar, estado: "Pendiente")
      @vacunas.each do |vacuna|
        vacuna.fecha_aplicacion = nil
        vacuna.save
      end
    end
    render "listar"
  end

  # POST /vaccinators
  def create
    if User.where(DNI: params[:vaccinator][:DNI]).count==1
      @user = User.find_by_DNI(params[:vaccinator][:DNI])
      if (@user.created_at.year == Date.today.year and @user.created_at.month == Date.today.month and @user.created_at.day == Date.today.day)
	      if not @user.vaccines.where(nombre_vacuna:"Fiebre amarilla").count>=1
          @vacuna = Vaccine.new()
          @vacuna.nombre_vacuna="Fiebre amarilla"
          @vacuna.fecha_aplicacion=Date.today
          @vacuna.lugar_act= current_user.lugar
          @vacuna.estado="Pendiente"
          @vacuna.dosis="Unica"
          @vacuna.user_id=@user.id
          if @vacuna.save
            redirect_to root_path, notice: "El paciente podra aplicarse la vacuna" 
          else
            redirect_to root_path, notice: "No se pudo solicitar intente nuevamente"
          end
	      else
		      redirect_to root_path, notice: "El paciente ya posee la vacuna"
	      end
      else
        redirect_to root_path, notice: "El paciente no fue registrado hoy"
      end
    else
      redirect_to root_path, notice: "El paciente todavia no fue agregado"
    end 
  end


end
