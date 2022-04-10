class Salvacion1 < ActiveRecord::Migration[6.1]
  def change
    create_table :salvacions
    add_column :salvacions, :lugar, :string
    add_column :salvacions, :name, :string
    add_column :salvacions, :apellido, :string
    add_column :salvacions, :email, :string
    add_column :salvacions, :riesgo, :boolean
    add_column :salvacions, :DNI, :string
    add_column :salvacions, :nacimiento, :date
    add_column :salvacions, :clave4, :integer
    add_column :salvacions, :encrypted_password, :string
  end
end
