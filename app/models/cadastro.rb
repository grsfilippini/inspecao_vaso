class Cadastro < ApplicationRecord
    #self.table_name = "cadastros"
    #self.primary_key = "id"

    # Campos obrigatórios
    validates :nome, presence: true
    validates :nome_curto, presence: true
    validates :cnpj, presence: true
    validates :corp_id, presence: true
    validates :url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true
    validates_length_of :nome, maximum: 100
    validates_length_of :nome_curto, maximum: 50
    validates_length_of :cnpj, maximum: 18
    validates_length_of :endereco, maximum: 75
    validates_length_of :cep, maximum: 10
    validates_length_of :email, maximum: 40    
    validates_length_of :fone, maximum: 35
    validates_length_of :contato, maximum: 35
    validates_length_of :website, maximum: 55
    validates_length_of :observacoes, maximum: 100
    validates_length_of :bairro, maximum: 60
    validates_length_of :regiao, maximum: 15
        
    belongs_to :corp#, foreign_key: 'corp_id'
    belongs_to :user
    belongs_to :cidade
    
    # Duas chaves estrangeiras com mesma tabela
    # A consulta de valores se dá através de fabricante_vasos e proprietaria_vasos
    has_many :fabricante_vasos,   class_name: 'Vaso', foreign_key: 'fabricante_id'
    has_many :proprietaria_vasos, class_name: 'Vaso', foreign_key: 'proprietaria_id'
    has_many :vasos, foreign_key: 'proprietaria_id'
    
    # Callback method, RoR
    after_create :seta_estatistica
    after_destroy :dec_estatistica
        
    # ***************************************************
    # Método de classe, pode ser chamado sem instanciar    
    # ***************************************************    
    def self.pesquisa_nome_corp(page, termo_nome, corp_id)                      
        if corp_id.blank?
           includes(:corp, :user)
          .where("lower(nome_curto) LIKE ?", "%#{termo_nome.downcase}%")
          .order(:nome_curto)
          .page(page)
          .per(50)
        else
           includes(:corp, :user)           
          .where("lower(nome_curto) LIKE ?", "%#{termo_nome.downcase}%")
          .where(corp_id: corp_id)
          .order(:nome_curto)
          .page(page)
          .per(50)          
        end
    end

    def self.pesquisa_nome_corp_pdf(termo_nome, corp_id)                      
      if corp_id.blank?
         includes(:corp, :user)
        .where("lower(nome_curto) LIKE ?", "%#{termo_nome.downcase}%")
        .order(:nome_curto)
      else
         includes(:corp, :user)           
        .where("lower(nome_curto) LIKE ?", "%#{termo_nome.downcase}%")
        .where(corp_id: corp_id)
        .order(:nome_curto)
      end
    end
    
    def TemVasoVencido(data_limite)
      vaso_vencido = false
      self.vasos.each do |vaso|
        if vaso.relatorios.any?
          r = vaso.relatorios.max_by { |relatorio| relatorio.id }
          if r.dt_prox_insp_externa <= data_limite
            vaso_vencido = true
            break
          end          
        end
      end
      return vaso_vencido
    end

    private
    
    def seta_estatistica
      AdminEstatistica.set_evento(AdminEstatistica::EVENTOS[:total_cadastros])      
    end
    
    def dec_estatistica
      AdminEstatistica.dec_evento(AdminEstatistica::EVENTOS[:total_cadastros])      
    end
        
end
