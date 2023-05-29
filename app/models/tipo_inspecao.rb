class TipoInspecao < ApplicationRecord
  # Campos obrigatórios
  validates :nome, presence: true    
        
  has_many :relatorios
end
