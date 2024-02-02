class AddRascunhoToVasos < ActiveRecord::Migration[5.2]
  def change
    add_column :vasos, :rascunho, :boolean, default: false
  end
end
