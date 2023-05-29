class AdminsBackoffice::ClasseFluidosController < AdminsBackofficeController
    before_action :set_classe_fluido, only: [:edit, :update, :destroy]    
    
    def index
      # O includes abaixo inclui na query a busca por classe_fluido      
      @classe_fluidos = ClasseFluido.all.order(:classe).page(params[:page]).per(10)
    end
  
    def new
      @classe_fluido = ClasseFluido.new
    end
  
    def create
      @classe_fluido = ClasseFluido.new(params_classe_fluido)
      if @classe_fluido.save
        redirect_to admins_backoffice_classe_fluidos_path, notice: "Classe de fluido criada com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @classe_fluido.update(params_classe_fluido)
        redirect_to admins_backoffice_classe_fluidos_path, notice: "Classe de fluido atualizada com sucesso!"    
      else
        render :edit
      end
    end
  
    def destroy
      if @classe_fluido.destroy
        redirect_to admins_backoffice_classe_fluidos_path, notice: "Classe de fluido excluída com sucesso!"    
      else
        render :index
      end
    end
  
  
    private
  
    
    def params_classe_fluido
      puts params
      params.require(:classe_fluido).permit(:id, :classe, :descricao)
    end
  
    def set_classe_fluido
      @classe_fluido = ClasseFluido.find(params[:id])
    end
end