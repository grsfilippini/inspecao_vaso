class MudarTimestampsParaNullFalse < ActiveRecord::Migration[5.2]
  def change
    #Deixar null true pois no lazarus não tem esta atualização
    #change_column_null :vasos, :created_at, false
    #change_column_null :vasos, :updated_at, false
  end
end
