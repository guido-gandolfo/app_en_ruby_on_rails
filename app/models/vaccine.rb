class Vaccine < ApplicationRecord
  belongs_to :user
  
  default_scope -> {order("nombre_vacuna asc")}
end
