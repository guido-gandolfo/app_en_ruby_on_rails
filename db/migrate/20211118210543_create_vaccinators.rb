class CreateVaccinators < ActiveRecord::Migration[6.1]
  def change
    create_table :vaccinators do |t|
      t.string :DNI

      t.timestamps
    end
  end
end
