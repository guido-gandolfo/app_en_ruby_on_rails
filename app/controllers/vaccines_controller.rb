class VaccinesController < ApplicationController
  before_action :set_vaccine, only: %i[show edit update destroy ], except: %i[darTurno]

  # GET /vaccines or /vaccines.json
  def index
    if current_user.rol=="Admin"
      @vaccines = Vaccine.all
    else
        @vacunas =current_user.vaccines
    end
  end

  def gripe
    @vacunas = Vaccine.all

  end

  def fiebre
    @vacunas = Vaccine.all
  end

  def covid
    @vacunas = Vaccine.all
  end


  # GET /vaccines/1 or /vaccines/1.json
  def show
    @vaccines =current_user.vaccines
    
    #Generacion del PDF para turno y vacuna aplicada
    respond_to do |format|
      format.html
      format.pdf do
        img = "#{Rails.root}/app/assets/images/logo.jpeg"
         pdf = VaccinePdf.new
         pdf.image img, :width => 60, :height => 60, at: [50, 730]
         pdf.fill_color "40464e"
         pdf.text_box "VACUNASSIST", :size => 30, at: [170, 710]
         pdf.move_down 70
         pdf.stroke_horizontal_rule
         pdf.move_down 20
         if @vaccine.estado =="Pendiente"
          valor = "de turno"
        else
          valor = "de vacuna aplicada"
        end
         pdf.text "Comprobante #{valor}", :size => 20, :style => :bold, :align => :left
         pdf.move_down 10
         pdf.stroke_horizontal_rule
         pdf.move_down 20

        if @vaccine.estado =="Pendiente"
            pdf.text "Turno para vacuna de #{@vaccine.nombre_vacuna}"
            pdf.move_down 7
        else
            pdf.text "Vacuna: #{@vaccine.nombre_vacuna}"
            pdf.move_down 7
        end
        pdf.text "Estado: #{@vaccine.estado}"
        pdf.move_down 7
        pdf.text "Dosis: #{@vaccine.dosis}"
        pdf.move_down 7
        pdf.text "Nombre: #{@vaccine.user.name}", :size => 13, :align => :left
        pdf.move_down 7
        pdf.text "Apellido: #{@vaccine.user.apellido}", :size => 13, :align => :left
        pdf.move_down 7
        pdf.text "DNI: #{@vaccine.user.DNI}", :size => 13, :align => :left
        pdf.move_down 7
        pdf.text "Lugar de aplicación: #{@vaccine.lugar_act}"
        pdf.move_down 7
        pdf.text "Fecha de aplicación: #{@vaccine.fecha_aplicacion}"
        pdf.move_down 7
        pdf.text "Descripción: #{@vaccine.descripcion}", :size => 13, :align => :left
        pdf.move_down 7
         send_data pdf.render, filename: "#{@vaccine}.pdf", 
                               type: "application/pdf", 
                               disposition: "inline"
      end
   end
  end

  # GET /vaccines/new
  def new
    @vaccine = Vaccine.new
  end

  # GET /vaccines/1/edit
  def edit
   
    @vaccine = Vaccine.find(params[:id])
    @user = User.find(@vaccine.user_id)
  end

  # POST /vaccines or /vaccines.json
  def create
        if not current_user.vaccines.where(nombre_vacuna:"Fiebre amarilla").count>=1
            @vacuna = Vaccine.new()
            @vacuna.nombre_vacuna="Fiebre amarilla"
            @vacuna.estado="Pendiente"
            @vacuna.dosis="Unica"
            @vacuna.user_id=current_user.id
            @vacuna.lugar_act = current_user.lugar
            if @vacuna.save
              redirect_to root_path, notice: "La vacuna fue solicitada correctamente" 
            else
              redirect_to root_path, notice: "No se pudo solicitar intente nuevamente"
            end
        else
            redirect_to root_path, notice: "Usted ya solicito turno para dicha vacuna"
        end
      
  end

  # PATCH/PUT /vaccines/1 or /vaccines/1.json
  def update
    if current_user.rol=="Admin"
      @vaccine = Vaccine.find(params[:id])
      @user = User.find(@vaccine.user_id)
      if @vaccine.nombre_vacuna == "Fiebre amarilla"
        params[:condicion] = "Fiebre amarilla"
      else
        if @vaccine.nombre_vacuna = "Gripe"
          params[:condicion] = "Gripe"
        else
          if @vaccine.nombre_vacuna = "Covid"
            params[:condicion] = "Covid"
          end
        end
      end
         respond_to do |format|
        if @vaccine.update(vacuna_params)
          if @vaccine.fecha_aplicacion==nil || @vaccine.fecha_aplicacion <= Date.today
            format.html { redirect_to vaccines_path(:condicion => @vaccine.nombre_vacuna), notice: "Debe especificar una fecha correcta para el turno" }
          else
            format.html { redirect_to vaccines_path(:condicion => @vaccine.nombre_vacuna), notice: "La fecha del turno ha sido modificada" }
          end
        else
          format.html { redirect_to edit_vaccine_path, status: :unprocessable_entity, notice: "Hubo un error en la carga de la ficha"   }
        end
      end
    else
      @vaccine = Vaccine.find(params[:id])
      @user = User.find(@vaccine.user_id)
      @vaccine.tipo_vacuna = params[:tipo_vacuna]
      @vaccine.descripcion = params[:descripcion]
      @vaccine.estado = "Atendido"
      @vaccine.vacunador_nombre = current_user.name
      @vaccine.vacunador_apellido = current_user.apellido
      @vaccine.save
      respond_to do |format|
          if @vaccine.update(vacuna_params)
            format.html { redirect_to vaccinators_listar_path, notice: "La ficha ha sido cargada" }
            format.json { render ':listar', status: :ok, location: @vaccinators }
          else
            format.html { redirect_to edit_vaccine_path, status: :unprocessable_entity, notice: "Hubo un error en la carga de la ficha"   }
            format.json { render '/vaccinators/listar', status: :unprocessable_entity }
          end
      end
    end
  end

  # DELETE /vaccines/1 or /vaccines/1.json
  def destroy
    @vaccine.destroy
    respond_to do |format|
      format.html { redirect_to vaccines_url, notice: "Vaccine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vaccine
      @vaccine = Vaccine.find(params[:id])
    end

    def vacuna_params
       params.require(:vaccine).permit(:estado, :lugar, :dosis, :tipo_vacuna, :descripcion, :fecha_aplicacion, :vacunador_nombre, :vacunador_apellido)
    end


end
