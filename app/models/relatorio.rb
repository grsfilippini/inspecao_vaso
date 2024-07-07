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
  #belongs_to :vaso  
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

  belongs_to :vaso
  accepts_nested_attributes_for :vaso, reject_if: :all_blank
  
  # Callback method, RoR
  after_create :seta_relatorio_ini_vaso
  after_create :seta_estatistica
  after_destroy :dec_estatistica  
  after_save :copiar_foto_instalacao_para_vaso
  after_update :copiar_foto_instalacao_para_vaso
  after_create :copiar_pressao_operacao
  
  # **************************************************
  # Método de classe, pode ser chamado sem instanciar    
  # **************************************************    
  def self.relatorios_concluidos(page)
    includes(:user, :proprietaria, :vaso)
      .where(b_rascunho: false, brel_impresso: true)
      .order(id: :desc)
      .page(page)
      .per(20)  
  end
  
  def self.relatorios_para_imprimir(page)
    includes(:user, :proprietaria, :vaso)
      .where(b_rascunho: false, brel_impresso: false)
      .order(id: :asc)
      .page(page)
      .per(20)  
  end
  
  def self.relatorios_em_aberto(page)
    includes(:user, :proprietaria, :vaso)
      .where(b_rascunho: true)
      .order(id: :asc)
      .page(page)
      .per(20)  
  end
  
  def self.relatorios_em_aberto_inspetor(inspetor, page)
    includes(:proprietaria, :vaso)
    .where(b_rascunho: true, inspetor_id: inspetor)
    .order(created_at: :desc)
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
  def dt_prox_insp_dispseg_externa_formatada
    dt_prox_insp_externa_dispositivo_seguranca.strftime('%d/%m/%Y') if dt_prox_insp_externa_dispositivo_seguranca.present?
  end
  def dt_prox_insp_dispseg_interna_formatada
    dt_prox_insp_interna_dispositivo_seguranca.strftime('%d/%m/%Y') if dt_prox_insp_interna_dispositivo_seguranca.present?
  end  
  
  private
  
  def seta_estatistica
    AdminEstatistica.set_evento(AdminEstatistica::EVENTOS[:total_relatorios])
  end
   
  def dec_estatistica
    AdminEstatistica.dec_evento(AdminEstatistica::EVENTOS[:total_relatorios])
  end

  # Caso o vaso ainda não possui relatório inicial, seta o relatório corrente como inicial
  def seta_relatorio_ini_vaso
    @vaso = Vaso.find(vaso_id)
    if @vaso.relatorio_ini_id == 0
      @vaso.relatorio_ini_id = id
      @vaso.save
    end
  end

  def copiar_foto_instalacao_para_vaso
    # Verifica se existe uma foto_instalacao
    if self.foto_instalacao.present?
      # Encontra o Vaso associado pelo vaso_id
      vaso_relacionado = Vaso.find_by(id: self.vaso_id)
      # Atualiza o campo foto_instalacao do Vaso com a foto do Relatorio
      vaso_relacionado.update(foto_instalacao: self.foto_instalacao)
    end
  end

  def copiar_pressao_operacao
    if self.pressostato_pliga.present? && self.pressostato_pdesliga.present?
      # Encontra o Vaso associado pelo vaso_id
      vaso_relacionado = Vaso.find_by(id: self.vaso_id)
      # Atualiza o campo pressão pressostato do Vaso com a do Relatorio
      vaso_relacionado.update(p_inf_operacao_fabricante: self.pressostato_pliga)
      vaso_relacionado.update(p_sup_operacao_fabricante: self.pressostato_pdesliga)
    end
  end
end
