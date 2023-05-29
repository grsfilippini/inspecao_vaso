class AdminsBackoffice::TipoDrenosController < AdminsBackofficeController
    before_action :set_tipo_dreno, only: [:edit, :update, :destroy]
    
    def index
      @tipo_drenos = TipoDreno.all.order(:tipo_dreno).page(params[:page]).per(5)
    end
  
    def new
      @tipo_dreno = TipoDreno.new
    end
  
    def create
      @tipo_dreno = TipoDreno.new(params_tipo_dreno)
      if @tipo_dreno.save
        redirect_to admins_backoffice_tipo_drenos_path, notice: "Tipo de dreno criado com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @tipo_dreno.update(params_tipo_dreno)
        redirect_to admins_backoffice_tipo_drenos_path, notice: "Tipo de dreno atualizado com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @tipo_dreno.destroy
        redirect_to admins_backoffice_tipo_drenos_path, notice: "Tipo de dreno excluído com sucesso!"
      else
        render :index
      end
    end
  
 
    private
  
    
    def params_tipo_dreno
      puts params
      params.require(:tipo_dreno).permit(:id, :tipo_dreno)
    end
  
    def set_tipo_dreno
      # Resgata o registro passado em id, para dentro da variável admin
      @tipo_dreno = TipoDreno.find(params[:id])
    end
  
  end 