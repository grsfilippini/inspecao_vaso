class EmpresasBackoffice::WelcomeController < EmpresasBackofficeController
  layout 'empresas_backoffice'
  def index
    @filiais = Cadastro.where(corp_id: current_empresa.corp_id).order(regiao: :asc).page(params[:page]).per(50)
  end
end