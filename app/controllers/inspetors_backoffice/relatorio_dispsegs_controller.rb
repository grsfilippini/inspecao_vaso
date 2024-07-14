class InspetorsBackoffice::RelatorioDispsegsController < InspetorsBackofficeController
    before_action :set_relatorio_dispseg, only: [:edit, :update, :destroy]
    before_action :get_relacoes, only: [:new, :edit]

    def index
        @relatorio_dispsegs = RelatorioDispseg
                              .where(brascunho: true, inspetor_id: current_inspetor.id)
                              .order(id: :desc)
                              .page(params[:page])
                              .per(50)

    end

    def new    
        @relatorio_dispseg = RelatorioDispseg.new
    end

    def create      
        @relatorio_dispseg = RelatorioDispseg.new(params_relatorio_dispseg)
        @relatorio_dispseg.inspetor_id = current_inspetor.id
        
        if @relatorio_dispseg.save  
          redirect_to inspetors_backoffice_relatorio_dispsegs_path, notice: "Relatório criado com sucesso!"        
        else
          get_relacoes
          render :new
        end
    end

    def edit # Ação de edição    
    end

    def destroy
        if @relatorio_dispseg.destroy
          redirect_to inspetors_backoffice_relatorio_dispsegs_path, notice: "Relatório excluído com sucesso!"
        else
          render :index
        end
    end
    
    def pesquisa
        params[:num_serie]
        
        @relatorio_dispsegs = RelatorioDispseg.joins(:vaso)
                              .where("LOWER(vasos.num_serie) LIKE LOWER(?)", "%#{params[:num_serie_vaso]}%")
                              .order(id: :desc)
                              .page(params[:page])
                              .per(50)


    end
  
  
  ##########
  # PRIVATE
  ##########
  private
    def set_relatorio_dispseg
      @relatorio_dispseg = RelatorioDispseg.find(params[:id])      
    end

    def params_relatorio_dispseg
        params.require(:relatorio_dispseg).permit(:data, 
                                                  :vaso_id,
                                                  :disp_seguranca_id,
                                                  :cadastro_id,
                                                  :bvalv_eh_estanque,
                                                  :bcorpo_bom_estado,
                                                  :broscas_bom_estado,
                                                  :bdiscovedacao_bom_estado,
                                                  :bhaste_bom_estado,
                                                  :bmola_bom_estado,
                                                  :bparafusoregulagem_bom_etado,
                                                  :balavanca_bom_estado,
                                                  :obs,
                                                  :pressao_ajuste)
      end

    def get_relacoes
        @arts               = Art.includes(:cadastro).order(id: :desc)
        @phs                = Ph.order(:nome)        
        @vasos              = Vaso.includes(:fabricante).order(:num_serie)
        @cadastros          = Cadastro.order(:nome_curto)
        @disp_segurancas    = DispSeguranca.includes(:cadastro).order(serie: :desc)
        @fluido_calibracao_valv_segs = FluidoCalibracaoValvSeg.all
        @instrumento_padraos = InstrumentoPadrao.all        
    end

end
