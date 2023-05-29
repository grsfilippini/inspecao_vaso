class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    
  # Validações
  # Essa validação será apenas na atualização, pois inicialmente pode-se cadastrar somente com o email.
  # A validação do nome é feita somente quando não estiver em processo de recuperação de senha,
  # por isso foi usado unless: reset_password_token_present?
  validates :nome, presence: true, length: {minimum: 3}, on: :update, unless: :reset_password_token_present?
   
  # Relações  
  has_one :perfil_usuario  
  accepts_nested_attributes_for :perfil_usuario, reject_if: :all_blank
  has_many :arts
  has_many :corps
  has_many :disp_segurancas
  has_many :espessura_vasos
  has_many :instrumento_padraos
  has_many :phs
  has_many :relatorio_dispsegs
  has_many :relatorios
  has_many :vasos
         
  # Método de instância.
  # Atributo virtual: nome_completo
  # Resgata o nome completo para o usuário atual (Self).
  def nome_completo
    [self.nome, self.sobrenome].join(" ")
  end
  
  
  # Callback method, RoR
  after_create :seta_estatistica
  after_destroy :dec_estatistica
  
  
  private
  
  def seta_estatistica
    AdminEstatistica.set_evento(AdminEstatistica::EVENTOS[:total_usuarios])
  end
  
  def dec_estatistica
    AdminEstatistica.dec_evento(AdminEstatistica::EVENTOS[:total_usuarios])
  end
  
  # As duas negações !!, transformam em um valor boleano.
  # Se trouxer o token retorna verdadeiro, caso contrário falso
  # O global params é definido em application_controller, em uma before_action
  def reset_password_token_present?
    !!$global_params[:user][:reset_password_token]
  end
  
end
