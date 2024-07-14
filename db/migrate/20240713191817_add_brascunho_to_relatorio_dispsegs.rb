class AddBrascunhoToRelatorioDispsegs < ActiveRecord::Migration[5.2]
  def change
    add_column :relatorio_dispsegs, :brascunho, :boolean, default: true

    reversible do |dir|
      dir.up { RelatorioDispseg.update_all(brascunho: false)}
    end
  end
end
