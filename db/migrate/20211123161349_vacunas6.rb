class Vacunas6 < ActiveRecord::Migration[6.1]
  def change
    add_column :vaccines, :descripcion, :text
  end
end
