class UsersController < ApplicationController
  def infovacunas
     @vacunas =current_user.vaccines
  end

   def xls_report
       #La variable @user contiene a la lista de los usuarios del vacunatorio.
      @user = User.all
      #En la siguiente linea, indicamos que plantilla usará el controlador para pintar la data
      render xlsx: 'user-list-report', template: 'users/reporte.xlsx.axlsx'
   end


   def buscarPersona
      #Busqueda del usuario por DNI
      @user= User.find_by DNI: params[:DNI]
      @vacunasGeneral = Vaccine.all
      #Si es admin
      if current_user.rol =="Admin"
            #Chequeo de la existencia del usuario buscado
            if not @user.present?
                  redirect_to root_path, notice: "No existe persona registrada con dicho DNI en el vacunatorio"
                  return
            else
               #Asigna las vacunas correspondiente al usuario
               @vacunas = @user.vaccines
               if @vacunas.count == 0
                  redirect_to root_path, notice: "La persona no tiene ninguna vacuna aplicada"
                  return
               end
               #Calcula para obtener edad
               @edad =  Date.today.year - @user.nacimiento.year

               if @user.riesgo == true
                  @riesgo = "SI"
               else
                  @riesgo = "NO"
               end
            end
      #Si es vacunador
      else
         if not @user.present?
            redirect_to vaccinators_listar_path, notice: "No existe persona registrada con dicho DNI en el vacunatorio"
         else
            @pendientes = @user.vaccines.where(fecha_aplicacion: Date.today, lugar_act: current_user.lugar, estado: "Pendiente").count
            if not @pendientes == 0
               @vacunas = @user.vaccines
            else
               redirect_to vaccinators_listar_path, notice: "El paciente no posee turno para el dia de la fecha"
               return
            end
         end
      end
   end

   def show
      @user = User.find(params[:id])
      @centro = Vaccination.find(params[@user.vaccination_id])
   end

  def index
     @users = User.all
  end


  def turnos
  end

  def edit
     @user =current_user
  end

  def update
     @user =current_user
     @zonaid =Vaccination.find_by_zona(params[:user][:lugar]).id
     @user.vaccination_id=@zonaid
     if @user.update(user_params)
         if Vaccine.where(nombre_vacuna: "Gripe",user_id: @user.id).count==0
            if (Date.today.year - @user.nacimiento.year) >= 18
               @vacuna = Vaccine.new()
               @vacuna.nombre_vacuna="Covid"
               @vacuna.estado="Pendiente"
               @vacuna.dosis="Primera"
               @vacuna.user_id=current_user.id
               @vacuna.lugar_act=params[:user][:lugar]
               @vacuna.save
            end
            @vacuna1 = Vaccine.new()
            @vacuna1.nombre_vacuna="Gripe"
            @vacuna1.estado="Pendiente"
            @vacuna1.dosis="Unica"
            @vacuna1.user_id=current_user.id
            @vacuna1.lugar_act=params[:user][:lugar]
            @vacuna1.save
            redirect_to users_perfil_path, notice: "Tu perfil ha sido actualizado y se han solicitado las vacunas de la gripe y covid"
         else
         redirect_to users_perfil_path, notice: "Tu perfil ha sido actualizado"
         end
      else
         redirect_to edit_user_path, notice: "Se ha introducido un mail o DNI ya existentes"     
      end
  end

  def listarVacunadores
   @vacunadores = User.where(rol: "Vacunador")
 end

 def listarAdministradores
   @administradores = User.where(rol: "Admin")
 end

 def asignarRol
   #Asigno rol vacunador a usuario por DNI
   @user = User.find_by DNI: params[:DNI]
   @nuevoRol = params[:rol]
   if current_user.rol =="Admin"
         #Chequeo de la existencia del usuario buscado
         if @user == nil
            if @nuevoRol=="Vacunador"
               redirect_to users_listarVacunadores_path, notice: "No existe persona registrada con dicho DNI en el vacunatorio"
            else
               redirect_to users_listarAdministradores_path, notice: "No existe persona registrada con dicho DNI en el vacunatorio"   
            end
         else
            @user.rol = @nuevoRol
            if @user.save
               if @nuevoRol=="Vacunador"
                  redirect_to users_listarVacunadores_path, notice: "El usuario ha sido asignado como vacunador"
               else
                  redirect_to users_listarAdministradores_path, notice: "El usuario ha sido asignado como administrador"   
               end
            end
         end
   end
end

def rolPaciente
   #Asigno rol vacunador a usuario por DNI
   @user = User.find_by DNI: params[:DNI]
   @rolAnterior = @user.rol
   if current_user.rol =="Admin"
         #Chequeo de la existencia del usuario buscado
         if not @user.present?
            redirect_to users_listarVacunadores_path, notice: "No existe persona registrada con dicho DNI en el vacunatorio"
         else
            @user.rol = "Paciente"
         end
         if @user.save
            if @rolAnterior=="Vacunador"
               redirect_to users_listarVacunadores_path, notice: "El ususario seleccionado ya no posee el rol de vacunador"
            else
               redirect_to users_listarAdministradores_path, notice: "El usuario seleccionado ya no posee el rol de administrador"   
            end
         end
   end
end

def editarZonaAux
   @user = User.find_by DNI: params[:DNI]
end

def editarZona
   @user = User.find_by DNI: params[:DNI]
   @nuevaZona = Vaccination.find_by id: params[:zona][:id]
   @user.lugar = @nuevaZona.zona
   @user.save
   redirect_to users_listarVacunadores_path, notice: "La zona se ha modificado correctamente"
end

  private

  def user_params
     params.require(:user).permit(:name,:apellido,:email,:riesgo,:vaccination_id, :lugar,:DNI,:nacimiento)
  end
end