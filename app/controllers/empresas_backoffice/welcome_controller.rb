class EmpresasBackoffice::WelcomeController < EmpresasBackofficeController
  before_action :get_relacoes, only: [:index, :pesquisa]
  def index
    @filiais = Cadastro.where(corp_id: current_empresa.corp_id)                       
                       .order(regiao: :asc)
                       .page(params[:page])
                       .per(50)
  end

  def pesquisa 
    if params[:filial_id].present? 
      @filiais = Cadastro.where(corp_id: current_empresa.corp_id)
                        .where(id: params[:filial_id]) 
                        .order(regiao: :asc)
                        .page(params[:page])
                        .per(50)
    elsif params[:termo_regiao].present? 
      @filiais = Cadastro.where(corp_id: current_empresa.corp_id)      
                         .where("lower(regiao) LIKE ?", "%#{params[:termo_regiao].downcase}%")
                         .order(regiao: :asc)
                         .page(params[:page])
                         .per(50)
    else
      @filiais = Cadastro.where(corp_id: current_empresa.corp_id)                       
                         .order(regiao: :asc)
                         .page(params[:page])
                         .per(50)
    end
  end

  private

  def get_relacoes
    @cadastros = Cadastro.where(corp_id: current_empresa.corp_id).order(:nome_curto)
  end

end