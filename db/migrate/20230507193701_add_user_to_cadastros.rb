class AddUserToCadastros < ActiveRecord::Migration[5.2]
  def change
    add_reference :cadastros, :user, foreign_key: true
  end
end
