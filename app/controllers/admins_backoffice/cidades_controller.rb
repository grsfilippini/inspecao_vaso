class AdminsBackoffice::CidadesController < AdminsBackofficeController
    before_action :set_cidade, only: [:edit, :update, :destroy]
    
    def index
      @cidades = Cidade.all.order(:nome).page(params[:page]).per(50)
    end
  
    def new
      @cidade = Cidade.new
    end
  
    def create
      @cidade = Cidade.new(params_cidade)
      if @cidade.save
        redirect_to admins_backoffice_cidades_path, notice: "Cidade criada com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @cidade.update(params_cidade)
        redirect_to admins_backoffice_cidades_path, notice: "Cidade atualizada com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @cidade.destroy
        redirect_to admins_backoffice_cidades_path, notice: "Cidade excluída com sucesso!"
      else
        render :index
      end
    end
  
  
    private
  
    
    def params_cidade
      puts params
      params.require(:cidade).permit(:nome)
    end
  
    def set_cidade
      @cidade = Cidade.find(params[:id])
    end
  
  end
  