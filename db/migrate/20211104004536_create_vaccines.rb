class CreateVaccines < ActiveRecord::Migration[6.1]
  def change
    create_table :vaccines do |t|
      t.string :nombre_vacuna
      t.date :fecha_aplicacion
      t.string :estado
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
