class AdminsBackoffice::CorpsController < AdminsBackofficeController
    before_action :set_corp, only: [:edit, :update, :destroy]
    before_action :get_relacoes, only: [:new, :edit]
    
    def index
      @corps = Corp.all.order(:nome).page(params[:page]).per(5)
    end
  
    def new
      @corp = Corp.new
    end
  
    def create
      @corp = Corp.new(params_corp)
      if @corp.save
        redirect_to admins_backoffice_corps_path, notice: "Corporação criada com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @corp.update(params_corp)        
        redirect_to admins_backoffice_corps_path, notice: "Corporação atualizada com sucesso!"
      else
        get_relacoes
        render :edit
      end
    end
  
    def destroy
      if @corp.destroy        
        redirect_to admins_backoffice_corps_path, notice: "Corporação excluída com sucesso!"
      else
        render :index
      end
    end
  
 
    private
  
    
    def params_corp
      puts params
      params.require(:corp).permit(:nome,
                                   :user_id)
    end
  
    def set_corp
      # Resgata o registro passado em id, para dentro da variável admin
      @corp = Corp.find(params[:id])
    end
    
    def get_relacoes
      @users = User.all.order(:nome).order(:sobrenome);      
    end
  
  end 