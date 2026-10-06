class AddFotoPressaoAberturaValvulaToRelatorios < ActiveRecord::Migration[5.2]
  def change
    add_column :relatorios, :foto_pressao_abertura_valvula, :binary
  end
end
