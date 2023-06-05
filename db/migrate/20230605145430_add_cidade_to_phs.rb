class AddCidadeToPhs < ActiveRecord::Migration[5.2]
  def change
    add_reference :phs, :cidade, foreign_key: true
  end
end
