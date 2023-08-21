class Relatorio < ApplicationRecord  
    
  # Campos com seleção obrigatória
  validates :tipo_inspecao,                 presence: true
  validates :art_id,                        presence: true
  validates :cidade_id,                     presence: true
  validates :data_relatorio,                presence: true
  validates :vaso_id,                       presence: true
  validates :proprietaria_id,               presence: true
  validates :inspetora_id,                  presence: true
  validates :fluido_servico_id,             presence: true
    
  # Relações  
  belongs_to :tipo_inspecao
  belongs_to :art
  belongs_to :cidade  
  belongs_to :vaso  
  belongs_to :proprietaria,  class_name: 'Cadastro'
  belongs_to :inspetora, class_name: 'Cadastro'
  #belongs_to :ambiente_inst
  #belongs_to :tipo_dreno
  belongs_to :ph
  belongs_to :finalidade_vaso
  belongs_to :fluido_servico
  belongs_to :mte_norma
  
  belongs_to :user
  
  has_one :corp, through: :proprietaria
  
  # Callback method, RoR
  after_create :seta_estatistica
  after_destroy :dec_estatistica
  after_create :seta_relatorio_ini_vaso
  
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
    
  # ***************************************************
  # Método de classe, pode ser chamado sem instanciar    
  # ***************************************************    
  def self.pesquisa_serie_prop(page, num_serie, proprietaria_id)    
    if !proprietaria_id.blank?      
      joins(:vaso)
      .includes(:user, :proprietaria, :vaso)
      .where("lower(vasos.num_serie) LIKE ?", "%#{num_serie.downcase}%" )
      .where(b_rascunho: false, proprietaria_id: proprietaria_id)      
      .order(id: :desc)      
      .page(page)
      .per(20)        
    else
      joins(:vaso)
      .includes(:user, :proprietaria, :vaso)
      .where("lower(vasos.num_serie) LIKE ?", "%#{num_serie.downcase}%" )
      .where(b_rascunho: false)      
      .order(id: :desc)      
      .page(page)
      .per(20)        
      
    end
  end
  
  # Método para obter a data formatada (campo virtual)
  def data_relatorio_formatada
    data_relatorio.strftime('%d/%m/%Y') if data_relatorio.present?
  end
  def dt_prox_insp_externa_formatada
    dt_prox_insp_externa.strftime('%d/%m/%Y') if dt_prox_insp_externa.present?
  end
  def dt_prox_insp_interna_formatada
    dt_prox_insp_interna.strftime('%d/%m/%Y') if dt_prox_insp_interna.present?
  end  
  
  private
  
  def seta_estatistica
    AdminEstatistica.set_evento(AdminEstatistica::EVENTOS[:total_relatorios])
  end
   
  def dec_estatistica
    AdminEstatistica.dec_evento(AdminEstatistica::EVENTOS[:total_relatorios])
  end

  def seta_relatorio_ini_vaso
    @vaso = Vaso.find(vaso_id)
    if @vaso.relatorio_ini_id == -1
      @vaso.relatorio_ini_id = id
      @vaso.save
    end
  end
end
