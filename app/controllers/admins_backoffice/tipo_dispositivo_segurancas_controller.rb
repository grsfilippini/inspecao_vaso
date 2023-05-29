class AdminsBackoffice::TipoDispositivoSegurancasController < AdminsBackofficeController
    before_action :set_tipo_dispositivo_seguranca, only: [:edit, :update, :destroy]
    
    def index
      @tipo_dispositivo_segurancas = TipoDispositivoSeguranca.all
                                                             .order(:nome)
                                                             .page(params[:page])
                                                             .per(5)
    end
  
    def new
      @tipo_dispositivo_seguranca = TipoDispositivoSeguranca.new
    end
  
    def create
      @tipo_dispositivo_seguranca = TipoDispositivoSeguranca.new(params_tipo_dispositivo_seguranca)
      if @tipo_dispositivo_seguranca.save
        redirect_to admins_backoffice_tipo_dispositivo_segurancas_path, notice: "Tipo dispositivo de segurança criado com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @tipo_dispositivo_seguranca.update(params_tipo_dispositivo_seguranca)
        redirect_to admins_backoffice_tipo_dispositivo_segurancas_path, notice: "Tipo dispositivo de segurança atualizado com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @tipo_dispositivo_seguranca.destroy
        redirect_to admins_backoffice_tipo_dispositivo_segurancas_path, notice: "Tipo dispositivo de segurança escluído com sucesso!"
      else
        render :index
      end
    end
  
 
    private
  
    
    def params_tipo_dispositivo_seguranca
      puts params
      params.require(:tipo_dispositivo_seguranca).permit(:id, :nome, :descricao)
    end
  
    def set_tipo_dispositivo_seguranca
      # Resgata o registro passado em id, para dentro da variável admin
      @tipo_dispositivo_seguranca = TipoDispositivoSeguranca.find(params[:id])
    end
  
  end 
