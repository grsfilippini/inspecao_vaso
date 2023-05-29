class AddUserToCodigoConstrucaos < ActiveRecord::Migration[5.2]
  def change
    add_reference :codigo_construcaos, :user, foreign_key: true
  end
end
