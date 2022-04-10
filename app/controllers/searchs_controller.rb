class SearchsController < ApplicationController
  def create
    @user= User.find_by DNI: params[:DNI]
    respond_to do |format|
      format.html { redirect_to search_buscado_path}
   
    end
  end

  def buscarPersona
    #Busqueda del usuario por DNI
    @user= User.find_by DNI: params[:DNI]

    #Chequeo de la existencia del usuario buscado
    if not @user.present?
          redirect_to root_path, notice: "No existe persona registrada con dicho DNI en el vacunatorio"
    else
       #Asigna las vacunas correspondiente al usuario
       @vacunas =@user.vaccines
       
       #Calcula para obtener edad
       @edad =  Date.today.year - @user.nacimiento.year
       
       if @user.riesgo == true
          @riesgo = "SI"
       else
          @riesgo = "NO"
       end
    end 
  end

end
