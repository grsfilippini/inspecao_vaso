class AdminEstatistica < ApplicationRecord
  EVENTOS = {
    total_usuarios: "TOTAL_USUARIOS",
    total_vasos: "TOTAL_VASOS",
    total_dispseg: "TOTAL_DISPSEG",
    total_cadastros: "TOTAL_CADASTROS",
    total_relatorios: "TOTAL_RELATORIOS",
    total_espessura_vaso: "TOTAL_ESPESSURA_VASO",
    total_rel_dispseg: "TOTAL_REL_DISPSEG"
  }
  
  def self.set_evento(evento)
    admin_estatistica = AdminEstatistica.find_or_create_by(evento: evento)
    admin_estatistica.valor += 1
    admin_estatistica.save
  end
  
  def self.dec_evento(evento)
    admin_estatistica = AdminEstatistica.find_by_evento(evento)
    admin_estatistica.valor -= 1
    admin_estatistica.save
  end
  
  def self.ajusta_total(evento, total)
    admin_estatistica = AdminEstatistica.find_by_evento(evento)
    admin_estatistica.valor = total
    admin_estatistica.save
  end;
end
