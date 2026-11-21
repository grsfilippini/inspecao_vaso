class TipoInspecao < ApplicationRecord
  # Campos obrigatórios
  validates :nome, presence: true    
        
  has_many :relatorios, foreign_key: :tipo_inspecao_id
end
