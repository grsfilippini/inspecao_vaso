class RemoveCampoFromRelatorios < ActiveRecord::Migration[5.2]
  def change
    remove_column :relatorios, :bman_tem_sinais_manutencao, :boolean
  end
end
