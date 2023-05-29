class AddUsetToRelatorioDispsegs < ActiveRecord::Migration[5.2]
  def change
    add_reference :relatorio_dispsegs, :user, foreign_key: true
  end
end
