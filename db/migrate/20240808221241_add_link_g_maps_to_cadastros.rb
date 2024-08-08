class AddLinkGMapsToCadastros < ActiveRecord::Migration[5.2]
  def change
    add_column :cadastros, :url, :string
  end
end
