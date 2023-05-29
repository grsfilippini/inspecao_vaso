class AdminsBackoffice::TipoVasosController < AdminsBackofficeController
    before_action :set_tipo_vaso, only: [:edit, :update, :destroy]
    
    def index
      @tipo_vasos = TipoVaso.all.order(:tipo_vaso).page(params[:page]).per(10)
    end
  
    def new
      @tipo_vaso = TipoVaso.new
    end
  
    def create
      @tipo_vaso = TipoVaso.new(params_tipo_vaso)
      if @tipo_vaso.save
        redirect_to admins_backoffice_tipo_vasos_path, notice: "Tipo de vaso criado com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @tipo_vaso.update(params_tipo_vaso)
        redirect_to admins_backoffice_tipo_vasos_path, notice: "Tipo de vaso atualizado com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @tipo_vaso.destroy
        redirect_to admins_backoffice_tipo_vasos_path, notice: "Tipo de vaso excluído com sucesso!"
      else
        render :index
      end
    end
  
 
    private
  
    
    def params_tipo_vaso
      puts params
      params.require(:tipo_vaso).permit(:id, :tipo_vaso)
    end
  
    def set_tipo_vaso
      # Resgata o registro passado em id, para dentro da variável admin
      @tipo_vaso = TipoVaso.find(params[:id])
    end
  
  end 
