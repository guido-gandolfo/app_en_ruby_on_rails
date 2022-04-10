class CreateCargarvacunas < ActiveRecord::Migration[6.1]
  def change
    create_table :cargarvacunas do |t|
      t.string :DNI
      t.string :dosis
      t.string :nombre
      t.text :descripcion

      t.timestamps
    end
  end
end
