class AdminsBackoffice::Catnr13sController < AdminsBackofficeController
    before_action :set_catnr13, only: [:edit, :update, :destroy]
    
    def index
      @catnr13s = Catnr13.all.order(:id).page(params[:page]).per(7)
    end
  
    def new
      @catnr13 = Catnr13.new
    end
  
    def create
      @catnr13 = Catnr13.new(params_catnr13)
      if @catnr13.save
        redirect_to admins_backoffice_catnr13s_path, notice: "Categoria criada com sucesso!"
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @catnr13.update(params_catnr13)
        redirect_to admins_backoffice_catnr13s_path, notice: "Categoria atualizada com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @catnr13.destroy
        redirect_to admins_backoffice_catnr13s_path, notice: "Categoria excluída com sucesso!"
      else
        render :index
      end
    end
  
  
    private
  
    
    def params_catnr13
      puts params
      params.require(:catnr13).permit(:categoria)
    end
  
    def set_catnr13
      @catnr13 = Catnr13.find(params[:id])
    end
  
  end