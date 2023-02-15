class Cidade < ApplicationRecord
    self.table_name = "CIDADES"
    self.primary_key = "ID"

    # Campos obrigatórios
    validates :Cidade, presence: true
    #validates :EstadoOuProvincia, presence: true
end