class InspetorsBackoffice::RelatoriosController < InspetorsBackofficeController
    def index
        @inspecoes_andamento = Relatorio.relatorios_em_aberto(params[:page])
        @nome_rel = 'em Aberto'
        #@proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
        #@em_aberto = TRUE
    end
end
