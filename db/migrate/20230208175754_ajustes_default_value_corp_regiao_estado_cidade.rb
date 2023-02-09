class AjustesDefaultValueCorpRegiaoEstadoCidade < ActiveRecord::Migration[5.2]
  def change
    change_column_default :cadastros, :eh_fabricante, false
    change_column_default :cadastros, :eh_empresa_inspetora, false
  end
end
