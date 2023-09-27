class AdminsBackoffice::RelatorioDispsegsController < AdminsBackofficeController
    before_action :set_relatorio_dispseg, only: [:edit, :update, :destroy]
    before_action :get_relacoes, only: [:new, :edit]
    
    def index
      @relatorio_dispsegs = RelatorioDispseg.where(bimpresso: false).order(id: :desc).page(params[:page]).per(10)
      # Indica que esta listagem é de relatórios que não foram impressos
      @para_imprimir = TRUE
    end
  
    def new        
      @relatorio_dispseg = RelatorioDispseg.new
      # Verifica se o parâmetro sel_relatorio_id está presente e não é nil
      if params[:sel_relatorio_id].present? && params[:sel_relatorio_id] != nil      
        # Faça suas atribuições aqui usando o valor de sel_relatorio_id
        relatorio_base = RelatorioDispseg.find(params[:sel_relatorio_id])
        attributes_to_assign = relatorio_base.attributes.except("id", "data", "bimpresso", "data_prox_insp", "bfoi_calibrada", "pressao_teste_1", "pressao_teste_2", "pressao_teste_3", "pressao_vedacao")  # Excluindo o campo "id"
        @relatorio_dispseg.assign_attributes(attributes_to_assign)
      end
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
        # Indica que esta listagem não é exclusivamente de relatórios que não foram impressos
        @para_imprimir = FALSE
    end

    def impresso
      @relatorio_dispsegs = RelatorioDispseg.where(bimpresso: true).order(id: :desc).page(params[:page]).per(10)
      # Indica que esta listagem é de relatórios que não foram impressos
      @para_imprimir = FALSE
    end

    def inicia_inspecao_proprietario
      @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
    end
 
    def get_relatorios_by_vaso
      vaso_id = params[:vaso_id]
      relatorios = RelatorioDispseg.where(vaso_id: vaso_id).order(id: :desc)    
      render json: relatorios.select(:id, :data).as_json
    end  

    def marcar_como_impresso
      @relatorio_dispseg = RelatorioDispseg.find(params[:id])
      @relatorio_dispseg.update(bimpresso: true)
      redirect_to admins_backoffice_relatorio_dispsegs_path, notice: "Relatório marcado como impresso."      
    end

    private
  
    
    def params_relatorio_dispseg
      puts params
      params.require(:relatorio_dispseg).permit(:user_id, 
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
                                                :bfoi_calibrada,
                                                :pressao_teste_1,
                                                :pressao_teste_2,
                                                :pressao_teste_3,
                                                :pressao_ajuste,
                                                :pressao_vedacao,
                                                :bimpresso,
                                                :data_prox_insp)
    end
  
    def set_relatorio_dispseg
      # Resgata o registro passado em id, para dentro da variável admin
      @relatorio_dispseg = RelatorioDispseg.find(params[:id])
    end
  
    def get_relacoes
        @users              = User.order(:nome).order(:sobrenome)
        @arts               = Art.includes(:cadastro).order(id: :desc)
        @phs                = Ph.order(:nome)        
        @vasos              = Vaso.includes(:fabricante).order(:num_serie)
        @cadastros          = Cadastro.order(:nome_curto)
        @disp_segurancas    = DispSeguranca.includes(:cadastro).order(serie: :desc)
        @fluido_calibracao_valv_segs = FluidoCalibracaoValvSeg.all
        @instrumento_padraos = InstrumentoPadrao.all        
    end

  end 