class MtpdsNumSerie < ApplicationRecord
    # Campos obrigatórios
    validates :serie, presence: true
    validates :disp_seguranca_id, presence: true    
    # Duas chaves estrangeiras com mesma tabela
    belongs_to :disp_seguranca
end
