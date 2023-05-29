class AdminsBackoffice::CodigoConstrucaosController < AdminsBackofficeController
    before_action :set_codigo_construcao, only: [:edit, :update, :destroy]    
    
    def index
      # O includes abaixo inclui na query a busca por codigo_construcao      
      @codigo_construcaos = CodigoConstrucao.all.order(:codigo).page(params[:page]).per(10)
    end
  
    def new
      @codigo_construcao = CodigoConstrucao.new
    end
  
    def create
      @codigo_construcao = CodigoConstrucao.new(params_codigo_construcao)
      if @codigo_construcao.save
        redirect_to admins_backoffice_codigo_construcaos_path, notice: "Código de construção criado com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @codigo_construcao.update(params_codigo_construcao)
        redirect_to admins_backoffice_codigo_construcaos_path, notice: "Código de construção atualizado com sucesso!"    
      else
        render :edit
      end
    end
  
    def destroy
      if @codigo_construcao.destroy
        redirect_to admins_backoffice_codigo_construcaos_path, notice: "Código de construção excluído com sucesso!"    
      else
        render :index
      end
    end
  
  
    private
  
    
    def params_codigo_construcao
      puts params
      params.require(:codigo_construcao).permit(:id, :codigo)
    end
  
    def set_codigo_construcao
      @codigo_construcao = CodigoConstrucao.find(params[:id])
    end
end