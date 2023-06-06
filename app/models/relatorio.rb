class Relatorio < ApplicationRecord  
    
  # Campos com seleção obrigatória
  validates :tipo_inspecao,                 presence: true
  validates :art_id,                        presence: true
  validates :cidade_id,                     presence: true
  validates :data_relatorio,                presence: true
  validates :vaso_id,                       presence: true
  validates :proprietaria_id,               presence: true
  validates :inspetora_id,                  presence: true
    
  # Relações  
  belongs_to :tipo_inspecao
  belongs_to :art
  belongs_to :cidade  
  belongs_to :vaso  
  belongs_to :proprietaria,  class_name: 'Cadastro'
  belongs_to :inspetora, class_name: 'Cadastro'
  belongs_to :tipo_ambiente_instalacao_vaso_pressao, class_name: 'AmbienteInst'
  belongs_to :tipo_acionamentodreno, class_name: 'TipoDreno'
  belongs_to :ph
  belongs_to :finalidade_vaso
  belongs_to :fluido_servico
  belongs_to :mte_norma
  
  belongs_to :user
  
  has_one :corp, through: :proprietaria
  
  # Callback method, RoR
  after_create :seta_estatistica
  after_destroy :dec_estatistica
  
  # **************************************************
  # Método de classe, pode ser chamado sem instanciar    
  # **************************************************    
  def self.relatorios_concluidos(page)
    includes(:user, :proprietaria, :vaso)
      .where(b_rascunho: false, brel_impresso: true)
      .order(id: :desc)
      .limit(50)
      .page(page)
      .per(20)  
  end
  
  def self.relatorios_para_imprimir(page)
    includes(:user, :proprietaria, :vaso)
      .where(b_rascunho: false, brel_impresso: false)
      .order(id: :desc)
      .limit(50)
      .page(page)
      .per(20)  
  end
  
  def self.relatorios_em_aberto(page)
    includes(:user, :proprietaria, :vaso)
      .where(b_rascunho: true)
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
