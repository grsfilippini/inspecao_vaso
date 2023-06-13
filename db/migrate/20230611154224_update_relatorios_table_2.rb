class UpdateRelatoriosTable2 < ActiveRecord::Migration[5.2]
  def change
    change_column_default :relatorios, :tipo_dreno_id, 0
    change_column_default :relatorios, :ambiente_inst_id, 2
  end
end
