class AddVacunatorio < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :vaccination, foreign_key: true
  end
end
