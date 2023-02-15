class RemoverColunasIeEPaisDoCadastro < ActiveRecord::Migration[5.2]
  def change
    remove_column(:cadastros, :ie)
    remove_column(:cadastros, :PAIS)
  end
end
