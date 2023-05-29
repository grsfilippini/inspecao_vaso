class CreateAdminEstatisticas < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_estatisticas do |t|
      t.string :evento
      t.integer :valor, default: 0

      t.timestamps
    end
  end
end
