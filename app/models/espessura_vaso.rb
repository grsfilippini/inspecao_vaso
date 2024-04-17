class EspessuraVaso < ApplicationRecord
  validates :user_id, presence: true  
  validates :vaso_id, presence: true  
  validates :data, presence: true
  validates :instrumento_padrao_id, presence: true
  validates :inspetora_id, presence: true
  #validates :esp_min_corpo, presence: true
  #validates :esp_min_tampo, presence: true
    
  belongs_to :user
  belongs_to :vaso
  belongs_to :inspetora,  class_name: 'Cadastro'

  has_one :instrumento_padrao
    
   # Callback method, RoR
  after_create :seta_estatistica
  after_destroy :dec_estatistica
  before_save :acerta_espessuras_minimas
 
  # ***************************************************
  # Método de classe, pode ser chamado sem instanciar    
  # ***************************************************    
  def self.pesquisa(page, num_serie, proprietaria_id, rascunho)      
    if !num_serie.blank?
      joins(:vaso).includes(:vaso, :inspetora, :user)
                  .where("lower(vasos.num_serie) LIKE ?", "%#{num_serie.downcase}%")
                  .where(b_rascunho: rascunho)
                  .order(id: :desc)
                  .page(page)
                  .per(10)
    elsif !proprietaria_id.blank?
      joins(:vaso).includes(:vaso, :inspetora, :user)
                  .where("vasos.proprietaria_id = ?", proprietaria_id) 
                  .where(b_rascunho: rascunho)   
                  .order(id: :desc)
                  .page(page)
                  .per(10)
    else
      includes(:vaso, :inspetora, :user).all
                                        .order(id: :desc)
                                        .where(b_rascunho: rascunho)
                                        .page(page)
                                        .per(10)
    end
  end

  private
  
  def seta_estatistica
    AdminEstatistica.set_evento(AdminEstatistica::EVENTOS[:total_espessura_vaso])
  end
   
  def dec_estatistica
    AdminEstatistica.dec_evento(AdminEstatistica::EVENTOS[:total_espessura_vaso])
  end

  def acerta_espessuras_minimas
    # PARA O CORPO
    #
    valores_espessuras_corpo = [
      self.esp_casco_1,
      self.esp_casco_4,
      self.esp_casco_5,
      self.esp_casco_6,
      self.esp_casco_9,
      self.esp_casco_10
    ]

    # Remove valores nil, pois eles podem interferir no cálculo do mínimo
    valores_espessuras_corpo.compact!

    # Calcula o menor valor entre as espessuras
    menor_espessura = valores_espessuras_corpo.min

    # Atribui o menor valor à coluna esp_min_corpo
    self.esp_min_corpo = menor_espessura

    # PARA O TAMPO
    #
    valores_espessuras_tampo = [
      self.esp_casco_2,
      self.esp_casco_3,
      self.esp_casco_7,
      self.esp_casco_8
    ]

    # Remove valores nil, pois eles podem interferir no cálculo do mínimo
    valores_espessuras_tampo.compact!

    # Calcula o menor valor entre as espessuras
    menor_espessura = valores_espessuras_tampo.min

    # Atribui o menor valor à coluna esp_min_corpo
    self.esp_min_tampo = menor_espessura
  end
end
