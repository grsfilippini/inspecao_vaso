class UpdateRelatoriosTable < ActiveRecord::Migration[5.2]
  def change
    change_column :relatorios, :tipo_dreno_id, :integer, null: true
    change_column :relatorios, :ambiente_inst_id, :integer, null: true
  end
end
