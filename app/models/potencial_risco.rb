class PotencialRisco < ApplicationRecord
    # Campos obrigatórios
    validates :potencial_risco, presence: true
    validates :descricao, presence: true
        
    has_many :vasos
end
