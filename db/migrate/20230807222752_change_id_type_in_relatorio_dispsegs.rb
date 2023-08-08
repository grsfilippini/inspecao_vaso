class ChangeIdTypeInRelatorioDispsegs < ActiveRecord::Migration[5.2]
  def up
    # Primeiro, criamos um novo ID com tipo SERIAL
    add_column :relatorio_dispsegs, :new_id, :serial

    # Em seguida, copiamos os dados da coluna ID para a nova coluna
    execute <<-SQL
      UPDATE relatorio_dispsegs
      SET new_id = id
    SQL

    # Por fim, definimos o novo ID como chave primária
    remove_column :relatorio_dispsegs, :id
    rename_column :relatorio_dispsegs, :new_id, :id
    execute 'ALTER TABLE relatorio_dispsegs ADD PRIMARY KEY (id);'
  end

  def down
    # Se quiser reverter essa alteração
    raise ActiveRecord::IrreversibleMigration
  end
end
