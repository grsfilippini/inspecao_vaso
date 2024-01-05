class RemoveCampoDrenoFromRelatorios < ActiveRecord::Migration[5.2]
  def change
    remove_column :relatorios, :bdreno_tem_sinais_manutencao, :boolean
  end
end
