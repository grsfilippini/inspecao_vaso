class UpdateNullNovaVendaFazerInspecaoInRelatorios < ActiveRecord::Migration[5.2]
  def up
    # Atualizar registros onde nova_venda_fazer_inspecao é NULL para false
    Relatorio.where(nova_venda_fazer_inspecao: nil).update_all(nova_venda_fazer_inspecao: false)
  end

  def down
    # Se desejar reverter, redefina o valor para NULL
    # Nota: Tome cuidado ao fazer down migrations que podem perder dados, esta é uma abordagem simples.
    Relatorio.where(nova_venda_fazer_inspecao: false).update_all(nova_venda_fazer_inspecao: nil)
  end
end
