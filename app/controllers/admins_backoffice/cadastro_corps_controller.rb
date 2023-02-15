class AdminsBackoffice::CadastroCorpsController < AdminsBackofficeController
    before_action :set_cadastro_corp, only: [:edit, :update, :destroy]
    
    def index
      @cadastro_corps = CadastroCorp.all.order(:CORPORACAO).page(params[:page]).per(5)
    end
  
    def new
      @cadastro_corp = CadastroCorp.new
    end
  
    def create
      @cadastro_corp = CadastroCorp.new(params_cadastro_corp)
      if @cadastro_corp.save
        redirect_to admins_backoffice_cadastro_corps_path, notice: "Corporação criada com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @cadastro_corp.update(params_cadastro_corp)
        redirect_to admins_backoffice_cadastro_corps_path, notice: "Corporação atualizada com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @cadastro_corp.destroy
        redirect_to admins_backoffice_cadastro_corps_path, notice: "Corporação excluída com sucesso!"
      else
        render :index
      end
    end
  
 
    private
  
    
    def params_cadastro_corp
      puts params
      params.require(:cadastro_corp).permit(:ID, :CORPORACAO)
    end
  
    def set_cadastro_corp
      # Resgata o registro passado em id, para dentro da variável admin
      @cadastro_corp = CadastroCorp.find(params[:id])
    end
  
  end
  