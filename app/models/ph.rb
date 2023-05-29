class Ph < ApplicationRecord
    # Campos obrigatórios
    validates :nome, presence: true
    validates :crea, presence: true
    
    # Relações
    belongs_to :user
end
