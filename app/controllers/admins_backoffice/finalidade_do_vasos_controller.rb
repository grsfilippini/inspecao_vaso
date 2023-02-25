class AdminsBackoffice::FinalidadeDoVasosController < AdminsBackofficeController
    before_action :set_finalidade_do_vaso, only: [:edit, :update, :destroy]
    
    def index
      @finalidade_do_vasos = FinalidadeDoVaso.all.order(:finalidade_do_vaso).page(params[:page]).per(7)
    end
  
    def new
      @finalidade_do_vaso = FinalidadeDoVaso.new
    end
  
    def create
      @finalidade_do_vaso = FinalidadeDoVaso.new(params_finalidade_do_vaso)
      if @finalidade_do_vaso.save
        redirect_to admins_backoffice_finalidade_do_vasos_path, notice: "Finalidade do vaso criada com sucesso!"
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @finalidade_do_vaso.update(params_finalidade_do_vaso)
        redirect_to admins_backoffice_finalidade_do_vasos_path, notice: "Finalidade do vaso atualizada com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @finalidade_do_vaso.destroy
        redirect_to admins_backoffice_finalidade_do_vasos_path, notice: "Finalidade do vaso excluída com sucesso!"
      else
        render :index
      end
    end
  
  
    private
  
    
    def params_finalidade_do_vaso
      puts params
      params.require(:finalidade_do_vaso).permit(:finalidade_do_vaso)
    end
  
    def set_finalidade_do_vaso
      @finalidade_do_vaso = FinalidadeDoVaso.find(params[:id])
    end
  
  end