class AddDataproxinspToRelatorioDispsegs < ActiveRecord::Migration[5.2]
  def change
    add_column :relatorio_dispsegs, :data_prox_insp, :date
  end
end
