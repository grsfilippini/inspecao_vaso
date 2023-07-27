class AddColumnsToEmpresa < ActiveRecord::Migration[5.2]
  def change
    add_column :empresas, :nome, :string
    add_reference :empresas, :corp, foreign_key: true
  end
end
