class AddArtToRelatorios < ActiveRecord::Migration[5.2]
  def change
    add_reference :relatorios, :art, foreign_key: true
  end
end
