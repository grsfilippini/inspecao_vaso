class AddTimestampsToRelatorioDispsegs < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :relatorio_dispsegs, null: true

    # Atualizar os registros existentes com valores default
    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          UPDATE relatorio_dispsegs
          SET created_at = NOW(), updated_at = NOW()
          WHERE created_at IS NULL OR updated_at IS NULL
        SQL
      end
    end

    change_column_null :relatorio_dispsegs, :created_at, false
    change_column_null :relatorio_dispsegs, :updated_at, false
  end
end
