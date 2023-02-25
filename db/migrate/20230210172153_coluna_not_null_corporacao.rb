class ColunaNotNullCorporacao < ActiveRecord::Migration[5.2]
  def change
    change_column_null :corps, :nome, false
  end
end
