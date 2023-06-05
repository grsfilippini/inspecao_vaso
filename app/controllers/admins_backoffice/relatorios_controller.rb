class AdminsBackoffice::RelatoriosController < AdminsBackofficeController
  
  def index
    @relatorios = Relatorio.relatorios_concluidos(params[:page])
  end
end
