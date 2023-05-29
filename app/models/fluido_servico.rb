class FluidoServico < ApplicationRecord
  # Campos obrigatórios
  validates :descricao, presence: true     
end
