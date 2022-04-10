class Search1 < ActiveRecord::Migration[6.1]
  def change
    create_table :searchs
    add_column :searchs, :DNI, :string
  end
end
