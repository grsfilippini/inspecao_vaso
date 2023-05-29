class Site::RelatoriosVasoController < SiteController
  def relatorios
    @vaso = Vaso.find(params[:vaso])
    
    @lista_rel = Relatorio.where("vaso_id = ?", params[:vaso]).order("id DESC").limit(1)
    if @lista_rel.length > 0
      @relatorio = @lista_rel[0]
    else
      @relatorio = nil
    end
    
   
  end
end
