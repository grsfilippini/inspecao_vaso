class AdminsBackoffice::TipoCompressorsController < AdminsBackofficeController
    before_action :set_tipo_compressor, only: [:edit, :update, :destroy]
    
    def index
      @tipo_compressors = TipoCompressor.all.order(:tipo_compressor).page(params[:page]).per(5)
    end
  
    def new
      @tipo_compressor = TipoCompressor.new
    end
  
    def create
      @tipo_compressor = TipoCompressor.new(params_tipo_compressor)
      if @tipo_compressor.save
        redirect_to admins_backoffice_tipo_compressors_path, notice: "Tipo de compressor criado com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @tipo_compressor.update(params_tipo_compressor)
        redirect_to admins_backoffice_tipo_compressors_path, notice: "Tipo de compressor atualizado com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @tipo_compressor.destroy
        redirect_to admins_backoffice_tipo_compressors_path, notice: "Tipo de compressor escluído com sucesso!"
      else
        render :index
      end
    end
  
 
    private
  
    
    def params_tipo_compressor
      puts params
      params.require(:tipo_compressor).permit(:id, :tipo_compressor)
    end
  
    def set_tipo_compressor
      # Resgata o registro passado em id, para dentro da variável admin
      @tipo_compressor = TipoCompressor.find(params[:id])
    end
  
  end 