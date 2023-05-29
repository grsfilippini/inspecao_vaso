class AddUserToDispSegurancas < ActiveRecord::Migration[5.2]
  def change
    add_reference :disp_segurancas, :user, foreign_key: true
  end
end
