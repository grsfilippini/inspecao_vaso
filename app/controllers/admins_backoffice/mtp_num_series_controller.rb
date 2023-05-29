class AdminsBackoffice::MtpNumSeriesController < AdminsBackofficeController
    before_action :set_mtp_num_serie, only: [:edit, :update, :destroy]
    before_action :get_relacoes, only: [:new, :edit]

    
    def index
      # O includes abaixo inclui na query a busca por mtp_num_serie      
      @mtp_num_series = MtpNumSerie.includes(:vaso)
                 .all
                 .order(:serie)
                 .page(params[:page])
                 .per(50)
    end
  
    def new
      @mtp_num_serie = MtpNumSerie.new      
    end
  
    def create
      @mtp_num_serie = MtpNumSerie.new(params_mtp_num_serie)
      if @mtp_num_serie.save
        redirect_to admins_backoffice_mtp_num_series_index_path, notice: "Número de série criado com sucesso!"
      else
        get_relacoes
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update
      if @mtp_num_serie.update(params_mtp_num_serie)
        redirect_to admins_backoffice_mtp_num_series_index_path, notice: "Número de série atualizado com sucesso!"    
      else
        get_relacoes
        render :edit
      end
    end
  
    def destroy
      if @mtp_num_serie.destroy
        redirect_to admins_backoffice_mtp_num_series_index_path, notice: "Número de série excluído com sucesso!"    
      else
        render :index
      end
    end
  
  
    private
  
    
    def params_mtp_num_serie
      puts params
      params.require(:mtp_num_serie).permit(:id, :serie, :vaso_id)
    end
  
    def set_mtp_num_serie        
      @mtp_num_serie = MtpNumSerie.find(params[:id])
    end
    
    def get_relacoes      
      @vasos = Vaso.order(:num_serie)
    end
end