class AddDefaultInspetorToRelatorios < ActiveRecord::Migration[5.2]
  def change
    change_column_default :relatorios, :inspetor_id, 1
  end
end
