class TipoDispositivoSeguranca < ApplicationRecord
    # Campos obrigatórios
    validates :nome,      presence: true
    validates :descricao, presence: true
end
