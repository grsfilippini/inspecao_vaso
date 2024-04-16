class AddBrascunhoToEspessuraVasos < ActiveRecord::Migration[5.2]
  def change
    add_column :espessura_vasos, :b_rascunho, :boolean, default: true
  end
end
