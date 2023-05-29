class TipoDreno < ApplicationRecord
   # Campos obrigatórios
   validates :tipo_dreno, presence: true    
        
   has_many :vasos
end
