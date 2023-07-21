class AdminsBackoffice::RelatorioDispsegsController < AdminsBackofficeController
    before_action :set_relatorio_dispseg, only: [:edit, :update, :destroy]
    before_action :get_relacoes, only: [:new, :edit]
    
    def index
      @relatorio_dispsegs = RelatorioDispseg.where(bimpresso: false).order(id: :desc).page(params[:page]).per(10)
    end
  
    def new        
      @relatorio_dispseg = RelatorioDispseg.new
    end
  
    def create        
      @relatorio_dispseg = RelatorioDispseg.new(params_relatorio_dispseg)
      if @relatorio_dispseg.save
        redirect_to admins_backoffice_relatorio_dispsegs_path, notice: "Relatório criado com sucesso!"
      else
        get_relacoes        
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @relatorio_dispseg.update(params_relatorio_dispseg)
        redirect_to admins_backoffice_relatorio_dispsegs_path, notice: "Relatório atualizado com sucesso!"
      else
        get_relacoes
        render :edit
      end
    end
  
    def destroy
      if @relatorio_dispseg.destroy
        redirect_to admins_backoffice_relatorio_dispsegs_path, notice: "Relatório excluído com sucesso!"
      else
        render :index
      end
    end
  
    def pesquisa
        # O includes abaixo inclui na query a busca 
        # Se não for usado, e usar diretamente na view da index, ele fará a cada cadastro uma nova query para buscar a corporação
        @relatorio_dispsegs = RelatorioDispseg.pesquisa(params[:page], params[:serie_dispseg], params[:serie_vaso])
    end

    def impresso
      @relatorio_dispsegs = RelatorioDispseg.where(bimpresso: true).order(id: :desc).page(params[:page]).per(10)
    end

 
    private
  
    
    def params_relatorio_dispseg
      puts params
      params.require(:relatorio_dispseg).permit(:id,
                                                :user_id, 
                                                :data, 
                                                :vaso_id,
                                                :disp_seguranca_id,
                                                :art_id,
                                                :cadastro_id,
                                                :ph_id,
                                                :bvalv_eh_estanque,
                                                :bcorpo_bom_estado,
                                                :broscas_bom_estado,
                                                :bdiscovedacao_bom_estado,
                                                :bhaste_bom_estado,
                                                :bmola_bom_estado,
                                                :bparafusoregulagem_bom_etado,
                                                :balavanca_bom_estado,
                                                :obs,
                                                :fluido_calibracao_valv_seg_id,
                                                :instrumento_padrao_id,
                                                :pressao_teste_1,
                                                :pressao_teste_2,
                                                :pressao_teste_3,
                                                :pressao_ajuste,
                                                :pressao_vedacao,
                                                :bimpresso)
    end
  
    def set_relatorio_dispseg
      # Resgata o registro passado em id, para dentro da variável admin
      @relatorio_dispseg = RelatorioDispseg.find(params[:id])
    end
  
    def get_relacoes
        @users              = User.order(:nome).order(:sobrenome)
        @arts               = Art.includes(:cadastro).order(id: :desc).limit(20)
        @phs                = Ph.order(:nome)        
        @vasos              = Vaso.includes(:fabricante).order(:num_serie)
        @cadastros          = Cadastro.order(:nome_curto)
        @disp_segurancas    = DispSeguranca.includes(:cadastro).order(serie: :desc)
        @fluido_calibracao_valv_segs = FluidoCalibracaoValvSeg.all
        @instrumento_padraos = InstrumentoPadrao.all        
    end

  end 