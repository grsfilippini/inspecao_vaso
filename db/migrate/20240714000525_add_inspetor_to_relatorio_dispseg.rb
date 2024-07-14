class AddInspetorToRelatorioDispseg < ActiveRecord::Migration[5.2]
  def change
    add_reference :relatorio_dispsegs, :inspetor, foreign_key: true
  end
end
