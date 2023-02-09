class AjustesNotNullCorpRegiaoEstadoCidade < ActiveRecord::Migration[5.2]
  def change
    change_column_null :corps,   :nome, false
    change_column_null :regiaos, :nome, false
    change_column_null :estados, :nome, false
    change_column_null :estados, :uf,   false
    change_column_null :cidades, :nome, false
  end
end
