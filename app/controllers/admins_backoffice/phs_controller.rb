class AdminsBackoffice::PhsController < AdminsBackofficeController
    before_action :set_ph, only: [:edit, :update, :destroy]
    before_action :get_relacoes, only: [:edit, :new]
    
    def index
      # O includes abaixo inclui na query a busca por ph      
      @phs = Ph.all.order(:nome).page(params[:page]).per(10)
    end
  
    def new
      @ph = Ph.new
    end
  
    def create
      @ph = Ph.new(params_ph)
      if @ph.save
        redirect_to admins_backoffice_phs_path, notice: "Profissional criado com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @ph.update(params_ph)
        redirect_to admins_backoffice_phs_path, notice: "Profissional atualizado com sucesso!"    
      else
        render :edit
      end
    end
  
    def destroy
      if @ph.destroy
        redirect_to admins_backoffice_phs_path, notice: "Profissional excluído com sucesso!"    
      else
        render :index
      end
    end
  
  
    private
  
    def get_relacoes
      @cidades = Cidade.all
    end
    
    def params_ph
      puts params
      params.require(:ph).permit(:id, :nome, :crea, :endereco, :cidade_id, :uf, :fone, :cep, :titulo, :bairro, :cpf, :rg, :email)
    end
  
    def set_ph
      @ph = Ph.find(params[:id])
    end  
  end