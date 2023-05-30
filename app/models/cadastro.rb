class Cadastro < ApplicationRecord
    #self.table_name = "cadastros"
    #self.primary_key = "id"

    # Campos obrigatórios
    validates :nome, presence: true
    validates :nome_curto, presence: true
    validates :cnpj, presence: true
    validates :corp_id, presence: true
    
    belongs_to :corp#, foreign_key: 'corp_id'
    belongs_to :user
    
    # Duas chaves estrangeiras com mesma tabela
    # A consulta de valores se dá através de fabricante_vasos e proprietaria_vasos
    has_many :fabricante_vasos,   class_name: 'Vaso', foreign_key: 'fabricante_id'
    has_many :proprietaria_vasos, class_name: 'Vaso', foreign_key: 'proprietaria_id'
    
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
    
    
    private
    
    def seta_estatistica
      AdminEstatistica.set_evento(AdminEstatistica::EVENTOS[:total_cadastros])      
    end
    
    def dec_estatistica
      AdminEstatistica.dec_evento(AdminEstatistica::EVENTOS[:total_cadastros])      
    end
        
end
