class AdminsBackoffice::FluidoServicosController < AdminsBackofficeController
    before_action :set_fluido_servico, only: [:edit, :update, :destroy]
    
    def index
      @fluido_servicos = FluidoServico.all.order(:descricao).page(params[:page]).per(5)
    end
  
    def new
      @fluido_servico = FluidoServico.new
    end
  
    def create
      @fluido_servico = FluidoServico.new(params_fluido_servico)
      if @fluido_servico.save
        redirect_to admins_backoffice_fluido_servicos_path, notice: "Fluído criado com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @fluido_servico.update(params_fluido_servico)
        redirect_to admins_backoffice_fluido_servicos_path, notice: "Fluído atualizado com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @fluido_servico.destroy
        redirect_to admins_backoffice_fluido_servicos_path, notice: "Fluído excluído com sucesso!"
      else
        render :index
      end
    end
  
 
    private
  
    
    def params_fluido_servico
      puts params
      params.require(:fluido_servico).permit(:id, :descricao)
    end
  
    def set_fluido_servico
      # Resgata o registro passado em id, para dentro da variável admin
      @fluido_servico = FluidoServico.find(params[:id])
    end
  
end
