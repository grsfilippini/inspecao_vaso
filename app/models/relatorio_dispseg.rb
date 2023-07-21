class RelatorioDispseg < ApplicationRecord
  # Campos obrigatórios
  validates :id,                            presence: true  
  #validates :user_id,                       presence: true
  validates :data,                          presence: true
  validates :vaso_id,                       presence: true
  validates :disp_seguranca_id,             presence: true
  validates :art_id,                        presence: true
  validates :cadastro_id,                   presence: true
  validates :ph_id,                         presence: true
  validates :pressao_ajuste,                presence: true

  belongs_to :user
  belongs_to :vaso
  belongs_to :cadastro
  belongs_to :disp_seguranca
  
   # Callback method, RoR
  after_create :seta_estatistica
  after_destroy :dec_estatistica
  
    # ***************************************************
    # Método de classe, pode ser chamado sem instanciar    
    # ***************************************************    
    def self.pesquisa(page, serie_dispseg, serie_vaso)
      joins(:vaso, :disp_seguranca)
        .where("lower(vasos.num_serie) LIKE ?", "%#{serie_vaso.downcase}%")
        .where("lower(disp_segurancas.serie) LIKE ?", "%#{serie_dispseg.downcase}%")
        .order(id: :desc)
        .page(page)
        .per(10)
    end


  private
  
  def seta_estatistica
    AdminEstatistica.set_evento(AdminEstatistica::EVENTOS[:total_rel_dispseg])
  end
    
  def dec_estatistica
    AdminEstatistica.dec_evento(AdminEstatistica::EVENTOS[:total_rel_dispseg])
  end
end
