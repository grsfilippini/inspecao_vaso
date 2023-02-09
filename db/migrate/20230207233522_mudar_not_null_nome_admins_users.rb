class MudarNotNullNomeAdminsUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :admins, :nome, false
    change_column_null :users,  :nome, false
  end
end