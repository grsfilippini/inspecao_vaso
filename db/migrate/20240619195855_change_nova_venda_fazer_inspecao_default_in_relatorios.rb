class ChangeNovaVendaFazerInspecaoDefaultInRelatorios < ActiveRecord::Migration[5.2]
  def change
    change_column_default :relatorios, :nova_venda_fazer_inspecao, from: nil, to: false
  end
end
