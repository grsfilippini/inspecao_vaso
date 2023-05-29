class AdminsBackoffice::WelcomeController < AdminsBackofficeController
  
  def index
    @total_usuarios       = AdminEstatistica.find_or_create_by(evento: AdminEstatistica::EVENTOS[:total_usuarios]).valor
    @total_vasos          = AdminEstatistica.find_or_create_by(evento: AdminEstatistica::EVENTOS[:total_vasos]).valor
    @total_cadastros      = AdminEstatistica.find_or_create_by(evento: AdminEstatistica::EVENTOS[:total_cadastros]).valor
    @total_dispseg        = AdminEstatistica.find_or_create_by(evento: AdminEstatistica::EVENTOS[:total_dispseg]).valor
    @total_relatorios     = AdminEstatistica.find_or_create_by(evento: AdminEstatistica::EVENTOS[:total_relatorios]).valor
    @total_espessura_vaso = AdminEstatistica.find_or_create_by(evento: AdminEstatistica::EVENTOS[:total_espessura_vaso]).valor
    @total_rel_dispseg    = AdminEstatistica.find_or_create_by(evento: AdminEstatistica::EVENTOS[:total_rel_dispseg]).valor
  end
end

