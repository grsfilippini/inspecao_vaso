class AjustesDefaultValueCorpRegiaoEstadoCidade2 < ActiveRecord::Migration[5.2]
  def change
    change_column_default :cadastros, :corp_id, 1
    change_column_default :cadastros, :regiao_id, 1
  end
end
