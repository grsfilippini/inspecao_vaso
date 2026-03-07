class AddForeignKeyRelatoriosFinalidadeVasos < ActiveRecord::Migration[5.2]
  def change
        add_foreign_key :relatorios, :finalidade_vasos, column: :finalidade_vaso_id
  end
end
