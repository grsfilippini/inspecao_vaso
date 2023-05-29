class AdminsBackoffice::FluidoCalibracaoValvSegsController < AdminsBackofficeController
    before_action :set_fluido_calibracao_valv_seg, only: [:edit, :update, :destroy]
    
    def index
      @fluido_calibracao_valv_segs = FluidoCalibracaoValvSeg.all.order(:descricao).page(params[:page]).per(5)
    end
  
    def new
      @fluido_calibracao_valv_seg = FluidoCalibracaoValvSeg.new
    end
  
    def create
      @fluido_calibracao_valv_seg = FluidoCalibracaoValvSeg.new(params_fluido_calibracao_valv_seg)
      if @fluido_calibracao_valv_seg.save
        redirect_to admins_backoffice_fluido_calibracao_valv_segs_path, notice: "Fluído criado com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @fluido_calibracao_valv_seg.update(params_fluido_calibracao_valv_seg)
        redirect_to admins_backoffice_fluido_calibracao_valv_segs_path, notice: "Fluído atualizado com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @fluido_calibracao_valv_seg.destroy
        redirect_to admins_backoffice_fluido_calibracao_valv_segs_path, notice: "Fluído excluído com sucesso!"
      else
        render :index
      end
    end
  
 
    private
  
    
    def params_fluido_calibracao_valv_seg
      puts params
      params.require(:fluido_calibracao_valv_seg).permit(:id, :descricao)
    end
  
    def set_fluido_calibracao_valv_seg
      # Resgata o registro passado em id, para dentro da variável admin
      @fluido_calibracao_valv_seg = FluidoCalibracaoValvSeg.find(params[:id])
    end
  
end