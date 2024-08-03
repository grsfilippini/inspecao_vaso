class AddBelaboradoFieldsToRelatorios < ActiveRecord::Migration[5.2]
  def change
    add_column :relatorios, :belaborado_memorial_calculo, :boolean
    add_column :relatorios, :belaborado_laudo_vaso_condenado, :boolean
    add_column :relatorios, :belaborado_relatorio_inspecao, :boolean
    add_column :relatorios, :belaborado_registro_inspecao, :boolean
    add_column :relatorios, :belaborado_registro_inspecao_dispseg, :boolean
  end
end
