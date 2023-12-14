class AddTagProprietariaToVasos < ActiveRecord::Migration[5.2]
  def change
    add_column :vasos, :tag_proprietaria, :string
  end
end
