class UpdateTimestampsInVasoExistente < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      UPDATE vasos SET created_at = NOW(), updated_at = NOW()
    SQL
  end
end
