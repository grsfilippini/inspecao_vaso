class AdminsBackoffice::AmbienteInstsController < AdminsBackofficeController
    before_action :set_ambiente_inst, only: [:edit, :update, :destroy]
    
    def index
      @ambiente_insts = AmbienteInst.all.order(:ambiente).page(params[:page]).per(10)
    end
  
    def new
      @ambiente_inst = AmbienteInst.new
    end
  
    def create
      @ambiente_inst = AmbienteInst.new(params_ambiente_inst)
      if @ambiente_inst.save
        redirect_to admins_backoffice_ambiente_insts_path, notice: "Ambiente de instalação criado com sucesso!"
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @ambiente_inst.update(params_ambiente_inst)
        redirect_to admins_backoffice_ambiente_insts_path, notice: "Ambiente de instalação atualizado com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @ambiente_inst.destroy
        redirect_to admins_backoffice_ambiente_insts_path, notice: "Ambiente de instalação excluído com sucesso!"
      else
        render :index
      end
    end
  
 
    private
  
    
    def params_ambiente_inst
      puts params
      params.require(:ambiente_inst).permit(:id, :ambiente)
    end
  
    def set_ambiente_inst
      # Resgata o registro passado em id, para dentro da variável admin
      @ambiente_inst = AmbienteInst.find(params[:id])
    end
  
  end 