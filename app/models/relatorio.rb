class Relatorio < ApplicationRecord  
    
  # Campos obrigatórios    
  validates :proprietaria_id,               presence: true  
  validates :tipo_inspecao,                 presence: true
  validates :data_relatorio,                presence: true
  validates :art_id,                        presence: true
  validates :cidade_id,                     presence: true
  validates :vaso_id,                       presence: true
    
  # Relações  
  belongs_to :vaso    
  belongs_to :user
  #has_one :corp, through: :proprietaria
  belongs_to :proprietaria,  class_name: 'Cadastro'
  
  # Callback method, RoR
  after_create :seta_estatistica
  after_destroy :dec_estatistica
  
  # **************************************************
  # Método de classe, pode ser chamado sem instanciar    
  # **************************************************    
  def self.relatorios_concluidos(page)
    includes(:user, :proprietaria, :vaso)
      .where(b_rascunho: false)
      .order(id: :desc)
      .limit(50)
      .page(page)
      .per(20)  
  end  
  
  
  private
  
  def seta_estatistica
    AdminEstatistica.set_evento(AdminEstatistica::EVENTOS[:total_relatorios])
  end
   
  def dec_estatistica
    AdminEstatistica.dec_evento(AdminEstatistica::EVENTOS[:total_relatorios])
  end
end
