class ChangeDefaultForBelaboradoRelatorioInspecao < ActiveRecord::Migration[5.2]
  def change
    change_column_default :relatorios, :belaborado_relatorio_inspecao, true
  end
end
