class CreateUserEstatisticas < ActiveRecord::Migration[5.2]
  def change
    create_table :user_estatisticas do |t|
      t.string :evento
      t.integer :valor
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
