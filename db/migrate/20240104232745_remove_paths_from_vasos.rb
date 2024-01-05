class RemovePathsFromVasos < ActiveRecord::Migration[5.2]
  def change
    remove_column :vasos, :path_plaqueta_original, :string
    remove_column :vasos, :path_plaqueta_atual, :string
  end
end
