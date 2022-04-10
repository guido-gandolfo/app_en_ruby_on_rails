class SalvacionsController < ApplicationController

    def new
        @salvacion = Salvacion.new
        @password = SecureRandom.random_number(9_00000)+1_00000
        @clave = SecureRandom.random_number(9_000)+1_000
     end
     
     def create
        @user = User.new
		@error = false
		@errorDNI = ""
		@errorEmail = ""
		@errorEdad = ""
        @user.nacimiento = params[:salvacion][:nacimiento]
		if(User.where(DNI: params[:salvacion][:DNI]).count > 0)
			@errorDNI = "El DNI ya existe en el sistema."
			@error = true
		end
		if(User.where(email: params[:salvacion][:email]).count > 0)
			@errorEmail = "El email ya existe en el sistema."
			@error = true
		end
		if (Date.today.year - @user.nacimiento.year <=59)
			@user.lugar = current_user.lugar
			@user.name = params[:salvacion][:name]
			@user.apellido = params[:salvacion][:apellido]
			@user.email = params[:salvacion][:email]
			@user.riesgo = params[:salvacion][:riesgo]
			@user.DNI = params[:salvacion][:DNI]
			@user.password = params[:contraseña]
			@user.clave4 = params[:clave]
			if @user.save
				redirect_to root_path, notice: "El usuario ha sido registrado"
				return
			end
		else
			@errorEdad = "El usuario es mayor a 60 años por lo cual no se puede registrar para aplicarse la vacuna de fiebre amarilla"
			@error = true
		end
		if @error
			@mensaje = @errorDNI + @errorEmail + @errorEdad
			redirect_to new_salvacion_path, notice: @mensaje
		end
     end

     def show
         @user = User.find(params[:id])
     end

end
