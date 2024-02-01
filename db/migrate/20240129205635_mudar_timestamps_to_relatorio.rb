class MudarTimestampsToRelatorio < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      UPDATE relatorios SET created_at = NOW(), updated_at = NOW()
    SQL
  end
end
