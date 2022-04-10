class Vacunasvacunador < ActiveRecord::Migration[6.1]
  def change
    add_column :vaccines, :vacunador_nombre, :string
    add_column :vaccines, :vacunador_apellido, :string
  end
end
