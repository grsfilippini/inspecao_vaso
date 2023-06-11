class AddTipoDrenoToRelatorios < ActiveRecord::Migration[5.2]
  def change
    add_reference :relatorios, :tipo_dreno, foreign_key: true
  end
end
