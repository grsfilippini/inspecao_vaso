class TipoVaso < ApplicationRecord
   # Campos obrigatórios
   validates :tipo_vaso, presence: true    
        
   has_many :vasos
end
