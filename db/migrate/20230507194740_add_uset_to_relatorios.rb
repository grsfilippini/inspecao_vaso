class AddUsetToRelatorios < ActiveRecord::Migration[5.2]
  def change
    add_reference :relatorios, :user, foreign_key: true
  end
end
