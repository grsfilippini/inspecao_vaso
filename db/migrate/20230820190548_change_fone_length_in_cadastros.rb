class ChangeFoneLengthInCadastros < ActiveRecord::Migration[5.2]
  def change
    change_column :cadastros, :fone, :string, limit: 35
  end
end
