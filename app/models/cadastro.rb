class Cadastro < ApplicationRecord
    #self.table_name = "cadastros"
    #self.primary_key = "id"

    # Campos obrigatórios
    validates :nome, presence: true
    validates :nome_curto, presence: true
    validates :cnpj, presence: true
    validates :corp_id, presence: true
    
    belongs_to :corp#, foreign_key: 'corp_id'
end
