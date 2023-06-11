class AddAmbienteInstToRelatorios < ActiveRecord::Migration[5.2]
  def change
    add_reference :relatorios, :ambiente_inst, foreign_key: true
  end
end
