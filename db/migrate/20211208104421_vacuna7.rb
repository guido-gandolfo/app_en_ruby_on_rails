class Vacuna7 < ActiveRecord::Migration[6.1]
  def change
    add_column :vaccines, :tipo_vacuna, :string
  end
end
