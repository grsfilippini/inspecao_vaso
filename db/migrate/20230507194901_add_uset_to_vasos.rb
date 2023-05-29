class AddUsetToVasos < ActiveRecord::Migration[5.2]
  def change
    add_reference :vasos, :user, foreign_key: true
  end
end
