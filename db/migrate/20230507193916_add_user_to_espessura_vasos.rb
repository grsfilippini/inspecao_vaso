class AddUserToEspessuraVasos < ActiveRecord::Migration[5.2]
  def change
    add_reference :espessura_vasos, :user, foreign_key: true
  end
end
