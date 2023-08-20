class AddBBloqueioInadvertidoIntencionalToRelatorios < ActiveRecord::Migration[5.2]
  def change
    add_column :relatorios, :bBloqueioInadvertidoIntencionalDoDispSeg, :boolean, default: false
  end
end
