class AmbienteInst < ApplicationRecord
    # Campos obrigatórios
    validates :ambiente, presence: true    
        
    #has_many :relatorios
end