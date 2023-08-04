class AdminsBackoffice::DispSegurancasController < AdminsBackofficeController
    before_action :set_disp_seguranca, only: [:edit, :update, :destroy]
    before_action :get_relacoes, only: [:new, :edit]

    
    def index
      # O includes abaixo inclui na query a busca por disp_seguranca      
      @disp_segurancas = DispSeguranca.includes(:cadastro, :tipo_dispositivo_seguranca, :user)
                 .all
                 .order(serie: :desc)
                 .page(params[:page])
                 .per(20)
    end
  
    def new
      @disp_seguranca = DispSeguranca.new
    end
  
    def create
      @disp_seguranca = DispSeguranca.new(params_disp_seguranca)
      if @disp_seguranca.save
        redirect_to admins_backoffice_disp_segurancas_path, notice: "Dispositivo de segurança criado com sucesso!"    
      else
        get_relacoes
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @disp_seguranca.update(params_disp_seguranca)
        redirect_to admins_backoffice_disp_segurancas_path, notice: "Dispositivo de segurança atualizado com sucesso!"    
      else
        get_relacoes
        render :edit
      end
    end
  
    def destroy
      if @disp_seguranca.destroy
        redirect_to admins_backoffice_disp_segurancas_path, notice: "Dispositivo de segurança excluído com sucesso!"    
      else
        render :index
      end
    end
  
    def obter_ultima_serie_mtpds
      last_record = MtpdsNumSerie.last
      serie = last_record&.serie || '' # Caso não haja registro, define um valor padrão vazio
      render json: { serie: serie }
    end
  
    private
  
    
    def params_disp_seguranca
      puts params
      params.require(:disp_seguranca).permit(:id, :serie, :cadastro_id, :tipo_dispositivo_seguranca_id, :castelo, :bitola, :user_id)
    end
  
    def set_disp_seguranca
      @disp_seguranca = DispSeguranca.find(params[:id])
    end
    
    def get_relacoes
      @cadastros = Cadastro.where(eh_fabricante: TRUE).order(:nome_curto)      
      @tipo_dispositivo_segurancas = TipoDispositivoSeguranca.order(:nome)
      @users = User.all.order(:nome)      
    end
end
