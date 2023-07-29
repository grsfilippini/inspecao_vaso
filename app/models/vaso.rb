class Vaso < ApplicationRecord
    
    # Duas chaves estrangeiras com mesma tabela
    belongs_to :fabricante,    class_name: 'Cadastro'
    belongs_to :proprietaria,  class_name: 'Cadastro'
    belongs_to :relatorio_ini, class_name: 'Relatorio' # SE LIBERAR ESTA LINHA, NÃO ACEITA -1 NO Vaso
    belongs_to :tipo_compressor
    belongs_to :tipo_dreno
    belongs_to :tipo_vaso
    belongs_to :codigo_construcao
    belongs_to :fluido_servico
    belongs_to :potencial_risco
    belongs_to :classe_fluido
    belongs_to :tipo_dispositivo_seguranca
    belongs_to :material
    belongs_to :catnr13
    
    belongs_to :user
    
    has_many :relatorios
    has_many :relatorio_dispsegs
    
    has_one :corp, through: :proprietaria
    
    # ***************************************************
    # Método de classe, pode ser chamado sem instanciar    
    # ***************************************************    
    def self.pesquisa_serie_prop(page, num_serie, proprietaria_id, corp_id)      
      
      if !proprietaria_id.blank?
          if corp_id.blank?
             includes(:proprietaria,  :fabricante, :user)            
            .where(proprietaria_id: proprietaria_id)
            .where("lower(num_serie) LIKE ?", "%#{num_serie.downcase}%")
            .order(:num_serie)
            .page(page)
            .per(10)
          else
             joins(proprietaria: :corp).where(corps: {id: corp_id})
            .includes(:proprietaria,  :fabricante, :user)            
            .where(proprietaria_id: proprietaria_id)
            .where("lower(num_serie) LIKE ?", "%#{num_serie.downcase}%")
            .order(:num_serie)
            .page(page)
            .per(10)
          end
      elsif !num_serie.blank?
          if corp_id.blank?
            includes(:proprietaria,  :fabricante, :user)          
            .where("lower(num_serie) LIKE ?", "%#{num_serie.downcase}%")
            .order(:num_serie)
            .page(page)
            .per(10)
          else
            joins(proprietaria: :corp).where(corps: {id: corp_id})
            .includes(:proprietaria,  :fabricante, :user)
            .where("lower(num_serie) LIKE ?", "%#{num_serie.downcase}%")
            .order(:num_serie)
            .page(page)
            .per(10)
          end
      else
          if corp_id.blank?
            includes(:proprietaria,  :fabricante, :user)
            .all
            .order(:num_serie)
            .page(page)
            .per(10)
          else
            joins(proprietaria: :corp).where(corps: {id: corp_id})
            .includes(:proprietaria,  :fabricante, :user)
            .all
            .order(:num_serie)
            .page(page)
            .per(10)
          end
      end
    end
    
    # ***************************************************
    # Método de classe, pode ser chamado sem instanciar
    # OS MÉTODOS ABAIXO FILTRAM POR current_user.id
    # ***************************************************
    def self.pesquisa(page, termo, usuario)
        Vaso.includes(:proprietaria,  :fabricante, :tipo_compressor,   :tipo_dreno,
                      :relatorio_ini, :tipo_vaso,  :codigo_construcao, :fluido_servico,
                      :classe_fluido, :tipo_dispositivo_seguranca,     :material,
                      :catnr13,       :corp)
            .where("lower(num_serie) LIKE ?", "%#{termo.downcase}%")
            .where(user_id: usuario)
            .order(:num_serie)
            .page(page)
            .per(10)    
    end
    
    def self.pesquisa_sem_pagina(termo, usuario)
        Vaso.where("lower(num_serie) LIKE ?", "%#{termo.downcase}%").where(user_id: usuario)
    end
    
    def self.ultimos_vasos(page, usuario)
        Vaso.includes(:proprietaria,  :fabricante, :tipo_compressor,   :tipo_dreno,
                      :relatorio_ini, :tipo_vaso,  :codigo_construcao, :fluido_servico,
                      :classe_fluido, :tipo_dispositivo_seguranca,     :material,
                      :catnr13,       :corp)
            .where(user_id: usuario)
            .order('created_at desc')
            .page(page)
            .per(10)  
    end
    
    def self.ultimos_vasos_sem_pagina(usuario)
        Vaso.where(user_id: usuario)
    end
    
    # Métodos scope, são métodos de classe que são utilizados apenas em pesquisa.
    # São métodos que podem ser encadeados em uma pesquisa.
    # Vaso.pesquisa1.pesquisa2
    scope :pesquisa_fabricante, -> (fabricante, page, usuario) {
             includes(:proprietaria,  :fabricante, :tipo_compressor,   :tipo_dreno,
                      :relatorio_ini, :tipo_vaso,  :codigo_construcao, :fluido_servico,
                      :classe_fluido, :tipo_dispositivo_seguranca,     :material,
                      :catnr13,       :corp)
            .where(fabricante_id: fabricante, user_id: usuario)
            .order(:num_serie)
            .page(page)
            .per(10)
           }    
    scope :pesquisa_fabricante_sem_pagina, -> (fabricante, usuario) {where(fabricante_id: fabricante, user_id: usuario)}
           
    scope :pesquisa_proprietaria, -> (proprietaria, page, usuario) {
             includes(:proprietaria,  :fabricante, :tipo_compressor,   :tipo_dreno,
                      :relatorio_ini, :tipo_vaso,  :codigo_construcao, :fluido_servico,
                      :classe_fluido, :tipo_dispositivo_seguranca,     :material,
                      :catnr13,       :corp)
            .where(proprietaria_id: proprietaria, user_id: usuario)
            .order(:num_serie)
            .page(page)
            .per(10)
           }    
    scope :pesquisa_proprietaria_sem_pagina, -> (proprietaria, usuario) {where(proprietaria_id: proprietaria, user_id: usuario)}
    
    scope :pesquisa_corporacao, -> (corporacao, page, usuario) {
              joins(proprietaria: :corp)
             .where(corps: {id: corporacao}, user_id: usuario)
             .page(page)
             .per(10)
           }    
    scope :pesquisa_corporacao_sem_pagina, -> (corporacao, usuario) {joins(proprietaria: :corp).where(corps: {id: corporacao}, user_id: usuario)}
    
    #*************************
    # Métodos scope para Admin
    #*************************
    #scope :pesquisa_corp_sem_pagina, -> (corp) {where(corp_id: corp)}
    #scope :pesquisa_prop_sem_pagina, -> (proprietaria) {where(proprietaria_id: proprietaria)}
    
        
    
  # Callback method, RoR
  after_create :seta_estatistica
  after_destroy :dec_estatistica
  
  private
  
  
  def seta_estatistica
    AdminEstatistica.set_evento(AdminEstatistica::EVENTOS[:total_vasos])
  end
    
  def dec_estatistica
    AdminEstatistica.dec_evento(AdminEstatistica::EVENTOS[:total_vasos])
  end
    
end
