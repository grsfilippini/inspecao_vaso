class AddInscricaoMunicipalToCadastro < ActiveRecord::Migration[5.2]
  def change
    add_column :cadastros, :im, :string, limit: 12
  end
end
