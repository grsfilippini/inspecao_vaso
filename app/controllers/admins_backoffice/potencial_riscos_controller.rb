class AdminsBackoffice::PotencialRiscosController < AdminsBackofficeController
    before_action :set_potencial_risco, only: [:edit, :update, :destroy]
    
    def index
      @potencial_riscos = PotencialRisco.all.order(:potencial_risco).page(params[:page]).per(10)
    end
  
    def new
      @potencial_risco = PotencialRisco.new
    end
  
    def create
      @potencial_risco = PotencialRisco.new(params_potencial_risco)
      if @potencial_risco.save
        redirect_to admins_backoffice_potencial_riscos_path, notice: "Potencial de risco criado com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @potencial_risco.update(params_potencial_risco)
        redirect_to admins_backoffice_potencial_riscos_path, notice: "Potencial de risco atualizado com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @potencial_risco.destroy
        redirect_to admins_backoffice_potencial_riscos_path, notice: "Potencial de risco excluído com sucesso!"
      else
        render :index
      end
    end
  
 
    private
  
    
    def params_potencial_risco
      puts params
      params.require(:potencial_risco).permit(:id, :potencial_risco, :descricao)
    end
  
    def set_potencial_risco
      # Resgata o registro passado em id, para dentro da variável admin
      @potencial_risco = PotencialRisco.find(params[:id])
    end
  
  end 