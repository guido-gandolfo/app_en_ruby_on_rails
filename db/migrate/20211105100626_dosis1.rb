class Dosis1 < ActiveRecord::Migration[6.1]
  def change
    add_column :vaccines, :dosis, :string
  end
end
