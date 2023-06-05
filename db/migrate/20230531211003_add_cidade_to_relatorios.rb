class AddCidadeToRelatorios < ActiveRecord::Migration[5.2]
  def change
    add_reference :relatorios, :cidade, foreign_key: true
  end
end
