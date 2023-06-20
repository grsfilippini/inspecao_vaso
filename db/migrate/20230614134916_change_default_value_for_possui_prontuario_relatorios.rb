class ChangeDefaultValueForPossuiProntuarioRelatorios < ActiveRecord::Migration[5.2]
  def change
    change_column_default :relatorios, :bexiste_prontuario, true
  end
end
