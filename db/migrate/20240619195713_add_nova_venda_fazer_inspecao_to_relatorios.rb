class AddNovaVendaFazerInspecaoToRelatorios < ActiveRecord::Migration[5.2]
  def change
    add_column :relatorios, :nova_venda_fazer_inspecao, :boolean
  end
end
