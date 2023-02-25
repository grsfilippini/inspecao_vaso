class MedidaEspessuraVaso < ApplicationRecord
    self.table_name = "MEDIDA_ESPESSURA_VASO"
    self.primary_key = "ID"

    # Campos obrigatórios
    #validates :nome, presence: true
    #validates :nome_curto, presence: true
    #validates :cnpj, presence: true
    #validates :CORP, presence: true

    #belongs_to :cadastro_corp, foreign_key: 'CORP'
end
