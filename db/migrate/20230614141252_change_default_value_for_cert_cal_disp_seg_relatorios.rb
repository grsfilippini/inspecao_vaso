class ChangeDefaultValueForCertCalDispSegRelatorios < ActiveRecord::Migration[5.2]
  def change
    change_column_default :relatorios, :possui_certif_calibracao_dispositivos_seguranca, 0
  end
end
