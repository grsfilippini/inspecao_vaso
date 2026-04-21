class AddBimpressoToEspessuraVasos < ActiveRecord::Migration[5.2]
  def change
    add_column :espessura_vasos, :bimpresso, :boolean
  end
end
