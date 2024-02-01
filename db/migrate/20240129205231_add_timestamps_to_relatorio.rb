class AddTimestampsToRelatorio < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :relatorios, null: true
  end
end
