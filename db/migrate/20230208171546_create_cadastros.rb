class CreateCadastros < ActiveRecord::Migration[5.2]
  def change
    create_table :cadastros do |t|      
      t.references :cidade, foreign_key: true
      t.references :regiao, foreign_key: true
      t.string :nome,null: false
      t.string :nome_curto,null: false
      t.string :cnpj,null: false
      t.string :logradouro
      t.string :numero
      t.string :bairro
      t.string :cep
      t.string :email
      t.string :fone
      t.string :contato
      t.string :website
      t.string :observacoes
      t.boolean :eh_fabricante
      t.boolean :eh_empresa_inspetora

      t.timestamps
    end
  end
end
