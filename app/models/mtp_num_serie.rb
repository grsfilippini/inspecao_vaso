class MtpNumSerie < ApplicationRecord
    # Campos obrigatórios
    validates :serie,   presence: true
    validates :vaso_id, presence: true
    # Duas chaves estrangeiras com mesma tabela
    belongs_to :vaso
end
