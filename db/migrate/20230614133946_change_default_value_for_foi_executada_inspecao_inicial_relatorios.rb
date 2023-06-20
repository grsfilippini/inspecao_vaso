class ChangeDefaultValueForFoiExecutadaInspecaoInicialRelatorios < ActiveRecord::Migration[5.2]
  def change
    change_column_default :relatorios, :foi_executada_inspecao_inicial, 0
  end
end
