class AddTimestampsToEspessuraVasos < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :espessura_vasos, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
