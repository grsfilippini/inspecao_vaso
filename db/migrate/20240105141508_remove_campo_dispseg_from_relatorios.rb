class RemoveCampoDispsegFromRelatorios < ActiveRecord::Migration[5.2]
  def change
    remove_column :relatorios, :bdispseg_tem_sinais_manutencao, :boolean
  end
end
