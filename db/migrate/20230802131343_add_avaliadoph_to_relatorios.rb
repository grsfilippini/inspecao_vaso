class AddAvaliadophToRelatorios < ActiveRecord::Migration[5.2]
  def change
    add_column :relatorios, :avaliadoph, :boolean
  end
end
