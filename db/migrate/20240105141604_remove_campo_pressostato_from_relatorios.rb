class RemoveCampoPressostatoFromRelatorios < ActiveRecord::Migration[5.2]
  def change
    remove_column :relatorios, :bpressostato_tem_sinais_manutencao, :boolean
  end
end
