class TipoCompressor < ApplicationRecord
    # Campos obrigatórios
    validates :tipo_compressor, presence: true    
        
    has_many :vasos
end