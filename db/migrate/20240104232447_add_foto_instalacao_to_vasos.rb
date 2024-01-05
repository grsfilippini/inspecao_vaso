class AddFotoInstalacaoToVasos < ActiveRecord::Migration[5.2]
  def change
    add_column :vasos, :foto_instalacao, :binary
  end
end
