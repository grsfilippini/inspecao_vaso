class Cidade < ApplicationRecord
    self.table_name = "cidades"
    self.primary_key = "id"

    # Campos obrigatórios
    validates :nome, presence: true
    #validates :EstadoOuProvincia, presence: true
end