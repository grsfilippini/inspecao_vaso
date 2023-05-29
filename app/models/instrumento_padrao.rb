class InstrumentoPadrao < ApplicationRecord
  # Campos obrigatórios
  validates :descricao,  presence: true
  validates :nome_curto, presence: true
  
  # Relações
  belongs_to :user
end
