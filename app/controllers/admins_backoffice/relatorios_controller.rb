class AdminsBackoffice::RelatoriosController < AdminsBackofficeController
  
  def index
    @relatorios = Relatorio.relatorios_concluidos(params[:page])
    @nome_rel = 'Concluídos'
  end
  
  def para_imprimir
    @relatorios = Relatorio.relatorios_para_imprimir(params[:page])
    @nome_rel = 'para Impressão'
  end
  
  def em_aberto
    @relatorios = Relatorio.relatorios_em_aberto(params[:page])
    @nome_rel = 'em Aberto (rascunho)'
  end
end
