class ChangeUserIdDefaultInRelatorioDispsegs < ActiveRecord::Migration[5.2]
  def change
    change_column_default :relatorio_dispsegs, :user_id, 1
  end
end
