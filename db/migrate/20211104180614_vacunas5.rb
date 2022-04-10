class Vacunas5 < ActiveRecord::Migration[6.1]
  def change
    add_column :vaccines, :lugar_act, :string
  end
end
