class CadastroCorp < ApplicationRecord
    self.table_name = "CADASTRO_CORP"
    self.primary_key = "ID"
    
    validates :CORPORACAO, presence: true

    has_many :cadastros, foreign_key: 'CORP'
end
