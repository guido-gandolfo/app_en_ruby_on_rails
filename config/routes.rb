Rails.application.routes.draw do
  get 'estadisticos/new'
  get 'estadisticos/edit'
  get 'estadisticos/todos'
  get 'estadisticos/vacunas'
  resources :estadisticos
  resources :vaccinations
  get 'cargarvacunas/new'
  resources 'users', only: [:edit,:update] 
  resources :vaccines
  resources 'vaccinators', only: [:new, :create]
  resources :salvacions
 
  get 'search/create'
  get 'vaccinators/listar'
  get 'vaccinators/asignar'
  get 'users/perfil'
  get 'users/clave'
  get 'users/infovacunas'
  get 'users/turnos'
  get 'users/update'
  root "users#turnos" 

  #Listado de turnos del admin
  get 'vaccines/fiebreAmarilla'
  get 'vaccines/covid'
  get 'vaccines/gripe'
  get 'vaccines/darTurno'

  #buscador
  resources :searchs
  resources :cargarvacunas
  get 'users/buscarPersona(.:format)', to: 'users#buscarPersona'

  #Administrar centros
  get 'vaccinations/show'
  get 'vaccinations/edit'

  #Administrar vacunadores y administradores
  get 'users/listarVacunadores'
  get 'users/listarAdministradores'
  get 'users/rolPaciente'
  get 'users/editarZonaAux'
  get 'users/asignarRol(.:format)', to: 'users#asignarRol'
  get 'users/editarZona(.:format)', to: 'users#editarZona'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_up', to: 'users/registrations#new'
    get 'forgot_password', to: 'users/passwords#new'
    get 'reset_password', to: 'users/passwords#edit'
  end
  
end
