class AdminsBackoffice::TipoInspecaosController < AdminsBackofficeController
    before_action :set_tipo_inspecao, only: [:edit, :update, :destroy]
    
    def index
      @tipo_inspecaos = TipoInspecao.all.order(:nome).page(params[:page]).per(5)
    end
  
    def new
      @tipo_inspecao = TipoInspecao.new
    end
  
    def create
      @tipo_inspecao = TipoInspecao.new(params_tipo_inspecao)
      if @tipo_inspecao.save
        redirect_to admins_backoffice_tipo_inspecaos_path, notice: "Tipo de inspeção criado com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @tipo_inspecao.update(params_tipo_inspecao)
        redirect_to admins_backoffice_tipo_inspecaos_path, notice: "Tipo de inspeção atualizado com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @tipo_inspecao.destroy
        redirect_to admins_backoffice_tipo_inspecaos_path, notice: "Tipo de inspeção excluído com sucesso!"
      else
        render :index
      end
    end
  
 
    private
  
    
    def params_tipo_inspecao
      puts params
      params.require(:tipo_inspecao).permit(:id, :nome)
    end
  
    def set_tipo_inspecao
      # Resgata o registro passado em id, para dentro da variável admin
      @tipo_inspecao = TipoInspecao.find(params[:id])
    end
  
end