class AddNomeToInspetors < ActiveRecord::Migration[5.2]
  def change
    add_column :inspetors, :nome, :string
  end
end
