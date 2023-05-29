class AdminsBackoffice::MtpdsNumSeriesController < AdminsBackofficeController
    before_action :set_mtpds_num_serie, only: [:edit, :update, :destroy]
    before_action :get_relacoes, only: [:new, :edit]

    
    def index
      # O includes abaixo inclui na query a busca por mtpds_num_serie      
      @mtpds_num_series = MtpdsNumSerie.includes(:disp_seguranca)
                 .all
                 .order(:serie)
                 .page(params[:page])
                 .per(50)
    end
  
    def new
      @mtpds_num_serie = MtpdsNumSerie.new      
    end
  
    def create
      @mtpds_num_serie = MtpdsNumSerie.new(params_mtpds_num_serie)
      if @mtpds_num_serie.save
        redirect_to admins_backoffice_mtpds_num_series_index_path, notice: "Número de série criado com sucesso!"
      else
        get_relacoes
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update
      if @mtpds_num_serie.update(params_mtpds_num_serie)
        redirect_to admins_backoffice_mtpds_num_series_index_path, notice: "Número de série atualizado com sucesso!"    
      else
        get_relacoes
        render :edit
      end
    end
  
    def destroy
      if @mtpds_num_serie.destroy
        redirect_to admins_backoffice_mtpds_num_series_index_path, notice: "Número de série excluído com sucesso!"    
      else
        render :index
      end
    end
  
  
    private
  
    
    def params_mtpds_num_serie
      puts params
      params.require(:mtpds_num_serie).permit(:id, :serie, :disp_seguranca_id)
    end
  
    def set_mtpds_num_serie        
      @mtpds_num_serie = MtpdsNumSerie.find(params[:id])
    end
    
    def get_relacoes      
      @disp_segurancas = DispSeguranca.order(:serie)
    end
end
