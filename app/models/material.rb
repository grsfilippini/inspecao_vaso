class Material < ApplicationRecord
    # Campos obrigatórios
    validates :descricao, presence: true
end
