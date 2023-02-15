class NotNullsNoCadastro < ActiveRecord::Migration[5.2]
  def change
    change_column_null :cadastros, :nome, false
    change_column_null :cadastros, :nome_curto, false
    change_column_null :cadastros, :cnpj, false    
  end
end
