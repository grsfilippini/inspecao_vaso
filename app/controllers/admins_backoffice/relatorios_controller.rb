class AdminsBackoffice::RelatoriosController < AdminsBackofficeController
  
  def index
    @relatorios = Relatorio.relatorios_concluidos(params[:page])
    @nome_rel = 'Concluídos'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
  end
  
  def para_imprimir
    @relatorios = Relatorio.relatorios_para_imprimir(params[:page])
    @nome_rel = 'para Impressão'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
  end
  
  def em_aberto
    @relatorios = Relatorio.relatorios_em_aberto(params[:page])
    @nome_rel = 'em Aberto (rascunho)'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
  end

  def pesquisa    
    @relatorios = Relatorio.pesquisa_serie_prop(params[:page], params[:num_serie], params[:proprietaria_id])
    @nome_rel = 'Concluídos (pesquisa)'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)    
  end
end
