class ClasseFluido < ApplicationRecord
    # Campos obrigatórios
    validates :classe,    presence: true
    validates :descricao, presence: true    
end
