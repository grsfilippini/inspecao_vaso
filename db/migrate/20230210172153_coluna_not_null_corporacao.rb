class ColunaNotNullCorporacao < ActiveRecord::Migration[5.2]
  def change
    change_column_null :CADASTRO_CORP, :CORPORACAO, false
  end
end
