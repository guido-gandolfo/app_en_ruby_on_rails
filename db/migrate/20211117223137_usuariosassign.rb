class Usuariosassign < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :rol, :string
  end
end
