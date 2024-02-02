class ColocaRascunhoEmFalse < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
          UPDATE vasos
          SET rascunho = false
    SQL
  end
end
