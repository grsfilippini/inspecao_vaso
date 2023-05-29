class DispSeguranca < ApplicationRecord
    # Campos obrigatórios
    validates :serie,                         presence: true
    validates :cadastro_id,                   presence: true
    validates :tipo_dispositivo_seguranca_id, presence: true
    
    # Duas chaves estrangeiras com mesma tabela
    belongs_to :cadastro
    belongs_to :tipo_dispositivo_seguranca
    belongs_to :user
    
    # Callback method, RoR
    after_create :seta_estatistica
    after_destroy :dec_estatistica
    
    
    private
    
    def seta_estatistica
      AdminEstatistica.set_evento(AdminEstatistica::EVENTOS[:total_dispseg])
    end
      
    def dec_estatistica
      AdminEstatistica.dec_evento(AdminEstatistica::EVENTOS[:total_dispseg])
    end
end
