class AdminsBackoffice::FinalidadeVasosController < AdminsBackofficeController
    before_action :set_finalidade_vaso, only: [:edit, :update, :destroy]
    
    def index
      @finalidade_vasos = FinalidadeVaso.all.order(:finalidade).page(params[:page]).per(7)
    end
  
    def new
      @finalidade_vaso = FinalidadeVaso.new
    end
  
    def create
      @finalidade_vaso = FinalidadeVaso.new(params_finalidade_vaso)
      if @finalidade_vaso.save
        redirect_to admins_backoffice_finalidade_vasos_path, notice: "Finalidade do vaso criada com sucesso!"
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @finalidade_vaso.update(params_finalidade_vaso)
        redirect_to admins_backoffice_finalidade_vasos_path, notice: "Finalidade do vaso atualizada com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @finalidade_vaso.destroy
        redirect_to admins_backoffice_finalidade_vasos_path, notice: "Finalidade do vaso excluída com sucesso!"
      else
        render :index
      end
    end
  
  
    private
  
    
    def params_finalidade_vaso
      puts params
      params.require(:finalidade_vaso).permit(:finalidade)
    end
  
    def set_finalidade_vaso
      @finalidade_vaso = FinalidadeVaso.find(params[:id])
    end
  
  end