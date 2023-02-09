class CreateRegiaos < ActiveRecord::Migration[5.2]
  def change
    create_table :regiaos do |t|
      t.references :corp, foreign_key: true
      t.string :nome

      t.timestamps
    end
  end
end
