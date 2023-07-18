class AdminsBackoffice::RelatorioDispsegsController < AdminsBackofficeController
    before_action :set_relatorio_dispseg, only: [:edit, :update, :destroy]
    before_action :get_relacoes, only: [:new, :edit]
    
    def index
      @relatorio_dispsegs = RelatorioDispseg.all.order(id: :desc).page(params[:page]).per(10)
    end
  
    def new
      @relatorio_dispseg = RelatorioDispseg.new
    end
  
    def create
      @relatorio_dispseg = RelatorioDispseg.new(params_relatorio_dispseg)
      if @relatorio_dispseg.save
        redirect_to admins_backoffice_relatorio_dispsegs_path, notice: "Relatório criado com sucesso!"
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @relatorio_dispseg.update(params_relatorio_dispseg)
        redirect_to admins_backoffice_relatorio_dispsegs_path, notice: "Relatório atualizado com sucesso!"
      else
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

 
    private
  
    
    def params_relatorio_dispseg
      puts params
      params.require(:relatorio_dispseg).permit(:data, :vaso_id)
    
    #   t.integer "vaso_id", null: false
    #   t.float "pressao_teste_1"
    #   t.float "pressao_teste_2"
    #   t.float "pressao_teste_3"
    #   t.float "pressao_ajuste", null: false
    #   t.float "pressao_vedacao", default: 0.0
    #   t.boolean "bcorpo_bom_estado", default: true, null: false
    #   t.boolean "broscas_bom_estado", default: true, null: false
    #   t.boolean "bdiscovedacao_bom_estado", default: true, null: false
    #   t.boolean "bhaste_bom_estado", default: true, null: false
    #   t.boolean "bmola_bom_estado", default: true, null: false
    #   t.boolean "bparafusoregulagem_bom_etado", default: true, null: false
    #   t.boolean "balavanca_bom_estado", default: true, null: false
    #   t.integer "fluido_calibracao_valv_seg_id", default: 1, null: false
    #   t.integer "instrumento_padrao_id", default: 2, null: false
    #   t.integer "cadastro_id", null: false
    #   t.boolean "bvalv_eh_estanque", default: true
    #   t.text "obs"
    #   t.boolean "bfoi_calibrada", default: false, null: false
    #   t.integer "disp_seguranca_id", null: false
    #   t.boolean "bimpresso", default: false
    #   t.integer "ph_id", default: 0, null: false
    #   t.integer "art_id", default: 0, null: false
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
    end

  end 