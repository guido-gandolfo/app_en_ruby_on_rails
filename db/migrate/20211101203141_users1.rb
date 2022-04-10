class Users1 < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :clave4, :integer
    add_column :users, :riesgo, :boolean
    add_column :users, :lugar, :string
  end
end
