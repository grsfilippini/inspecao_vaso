class AddInspetorToRelatorios < ActiveRecord::Migration[5.2]
  def change
    add_reference :relatorios, :inspetor, foreign_key: true
  end
end
