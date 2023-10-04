class AddSeqRoteiroToCadastros < ActiveRecord::Migration[5.2]
  def change
    add_column :cadastros, :seq_roteiro, :integer
  end
end
