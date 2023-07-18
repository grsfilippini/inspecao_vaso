class RelatorioDispseg < ApplicationRecord
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
