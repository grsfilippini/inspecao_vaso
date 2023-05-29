class AddTimestampsToVasoExistente < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :vasos, null: true
  end
end
