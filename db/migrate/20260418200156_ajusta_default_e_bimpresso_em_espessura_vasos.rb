class AjustaDefaultEBimpressoEmEspessuraVasos < ActiveRecord::Migration[5.2]
  def up
    change_column_default :espessura_vasos, :bimpresso, false

    execute <<-SQL
      UPDATE espessura_vasos
      SET bimpresso = FALSE
      WHERE b_rascunho = TRUE;
    SQL

    execute <<-SQL
      UPDATE espessura_vasos
      SET bimpresso = TRUE
      WHERE b_rascunho IS DISTINCT FROM TRUE;
    SQL
  end

  def down
    change_column_default :espessura_vasos, :bimpresso, true
  end
end