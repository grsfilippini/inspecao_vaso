class CreatePerfilUsuarios < ActiveRecord::Migration[5.2]
  def change
    create_table :perfil_usuarios do |t|
      t.string :endereco
      t.string :sexo
      t.date :aniversario
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
