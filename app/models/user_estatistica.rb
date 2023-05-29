class UserEstatistica < ApplicationRecord
  belongs_to :user

  EVENTOS = {
    #cadastros
    total_cliente:              "TOTAL_CLIENTE",
    total_corp:                 "TOTAL_CORP",
    total_vaso:                 "TOTAL_VASO",
    total_dispseg:              "TOTAL_DISPSEG",
    total_instrumento_padrao:   "TOTAL_INSTRUMENTO_PADRAO",
    total_fabricante:           "TOTAL_FABRICANTE",
    total_ph:                   "TOTAL_PH",
    # emissão
    total_art:                  "TOTAL_ART",
    total_rel_insp_inicial:     "TOTAL_REL_INSP_INICIAL",
    total_rel_insp_periodica:   "TOTAL_REL_INSP_PERIODICA",
    total_rel_insp_outras:      "TOTAL_REL_INSP_OUTRA",
    total_rel_esp_parede:       "TOTAL_REL_ESP_PAREDE",
    total_rel_disp_seg:         "TOTAL_REL_DISP_SEG",
    total_cert_cal_disp_seg:    "TOTAL_CERT_CAL_DISP_SEG"
  }
  
  def self.set_evento(user, evento)
    user_estatistica = UserEstatistica.find_or_create_by(user: user, evento: evento)
    user_estatistica.valor += 1
    user_estatistica.save
  end
  
  def self.dec_evento(user, evento)
    user_estatistica = UserEstatistica.find_by(user: user, evento: evento)
    user_estatistica.valor -= 1
    user_estatistica.save
  end
  
  def self.ajusta_total(user, evento, total)
    user_estatistica = UserEstatistica.find_by(user: user, evento: evento)
    user_estatistica.valor = total
    user_estatistica.save
  end;
end
