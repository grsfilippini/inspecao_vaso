class ChaveEstrangeiraVasoCadastro < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key(:vasos, :cadastros, column: :fabricante_id, primary_key: "id")
    add_foreign_key(:vasos, :cadastros, column: :proprietaria_id, primary_key: "id")
  end
end
