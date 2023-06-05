class AddCidadeToCadastros < ActiveRecord::Migration[5.2]
  def change
    add_reference :cadastros, :cidade, foreign_key: true
  end
end
