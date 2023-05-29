class RelatorioDispseg < ApplicationRecord
  belongs_to :user
  
   # Callback method, RoR
  after_create :seta_estatistica
  after_destroy :dec_estatistica
  
  private
  
  def seta_estatistica
    AdminEstatistica.set_evento(AdminEstatistica::EVENTOS[:total_rel_dispseg])
  end
    
  def dec_estatistica
    AdminEstatistica.dec_evento(AdminEstatistica::EVENTOS[:total_rel_dispseg])
  end
end
