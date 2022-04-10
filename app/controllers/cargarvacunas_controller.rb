class CargarvacunasController < ApplicationController
  def new
    @cargar=Cargarvacuna.new
  end
  def create
    if User.where(DNI: params[:cargarvacuna][:DNI]).count==1
      @user = User.find_by_DNI(params[:cargarvacuna][:DNI])
      if @user.vaccines.where(nombre_vacuna: params[:cargarvacuna][:nombre]).count>=1
       
        @vacunaact=Vaccine.new
        @vacunaact.estado="Atendido"
        @vacunaact.user_id=@user.id
        @vacunaact.nombre_vacuna=params[:cargarvacuna][:nombre]
        @vacunaact.descripcion= params[:cargarvacuna][:descripcion]
        @vacunaact.dosis= params[:cargarvacuna][:dosis]
        @vacunaact.fecha_aplicacion= Date.today
        @vacunaact.lugar_act=current_user.lugar
        if @vacunaact.save
          redirect_to root_path, notice: "La ficha se cargo con exito" 
        else
          redirect_to root_path, notice: "No se pudo cargar la ficha"
        end
      else
        redirect_to root_path, notice: "El paciente no se aplico nunca la vacuna"
      end
    else
      redirect_to root_path, notice: "Ese paciente no existe en el sitio"
    end 
  end

  


  def update
    @uusuario = User.find(params[:user][:id])
    @vaccine = @user.vaccines.where(nombre_vacuna: params[:cargarvacuna][:nombre])
		if @vaccine.update_attributes(vaccine_params)
			redirect_to @user
		else
			render 'edit'
		end
  end

  def vaccine_params
		params.require(:vaccine).permit(:fecha_aplicacion, :dosis, :descripcion)
	end
end
