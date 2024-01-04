class AddCalDispSegToRelatorios < ActiveRecord::Migration[5.2]
  def change
    add_column :relatorios, :serv_contratado_dispseg_calibracao, :Boolean
  end
end
