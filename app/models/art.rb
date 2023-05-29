class Art < ApplicationRecord
    # Campos obrigatórios
    validates :art,         presence: true
    validates :cadastro_id, presence: true
    validates :ph_id,       presence: true
    
    # Duas chaves estrangeiras com mesma tabela
    belongs_to :cadastro
    belongs_to :ph
    belongs_to :user
end
