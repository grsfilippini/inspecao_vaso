class EspessuraVaso < ApplicationRecord
  validates :user_id, presence: true  
  validates :vaso_id, presence: true  
  validates :data, presence: true
  validates :instrumento_padrao_id, presence: true
  validates :inspetora_id, presence: true
  validates :esp_min_corpo, presence: true
  validates :esp_min_tampo, presence: true
    
  belongs_to :user
  belongs_to :vaso
  belongs_to :inspetora,  class_name: 'Cadastro'

  has_one :instrumento_padrao
    
   # Callback method, RoR
  after_create :seta_estatistica
  after_destroy :dec_estatistica
  
  # ***************************************************
  # Método de classe, pode ser chamado sem instanciar    
  # ***************************************************    
  def self.pesquisa(page, num_serie, proprietaria_id)      
    if !num_serie.blank?
      joins(:vaso).includes(:vaso, :inspetora, :user)
                  .where("lower(vasos.num_serie) LIKE ?", "%#{num_serie.downcase}%")    
                  .order(id: :desc)
                  .page(page)
                  .per(10)
    elsif !proprietaria_id.blank?
      joins(:vaso).includes(:vaso, :inspetora, :user)
                  .where("vasos.proprietaria_id = ?", proprietaria_id)    
                  .order(id: :desc)
                  .page(page)
                  .per(10)
    else
      includes(:vaso, :inspetora, :user).all
                                        .order(id: :desc)
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
end
