class AdminsBackoffice::EspessuraVasosController < AdminsBackofficeController    
    before_action :set_espessura_vaso, only: [:edit, :update, :destroy]    
    before_action :get_relacoes, only: [:new, :edit]

    def index
        @espessura_vasos = EspessuraVaso.pesquisa(params[:page], nil, nil)
        @proprietarias = Cadastro.order(:nome_curto)
    end

    def pesquisa        
        @espessura_vasos = EspessuraVaso.pesquisa(params[:page], params[:num_serie], params[:proprietaria_id])                
        @proprietarias = Cadastro.order(:nome_curto)
    end


    def new
        @espessura_vaso = EspessuraVaso.new
    end  
    
    def create
        @espessura_vaso = EspessuraVaso.new(params_espessura_vaso)
        if @espessura_vaso.save
          redirect_to admins_backoffice_espessura_vasos_path, notice: "Espessura de vaso criada com sucesso!"
        else
          get_relacoes
          render :new
        end
    end

    def edit
    end

    def update        
        if @espessura_vaso.update(params_espessura_vaso)
            redirect_to admins_backoffice_espessura_vasos_path, notice: "Espessura vaso atualizada com sucesso!"
        else
            get_relacoes
            render :edit
        end
    end

    def destroy
        if @espessura_vaso.destroy
            redirect_to admins_backoffice_espessura_vasos_path, notice: "Espessura vaso excluída com sucesso!"
        else
            render :index
        end
    end


    private
    

    def params_espessura_vaso        
        params.require(:espessura_vaso).permit(:user_id, 
                                               :vaso_id,
                                               :data,
                                               :instrumento_padrao_id,
                                               :inspetora_id,                                               
                                               :esp_casco_1,
                                               :esp_casco_2,
                                               :esp_casco_3,
                                               :esp_casco_4,
                                               :esp_casco_5,
                                               :esp_casco_6,
                                               :esp_casco_7,
                                               :esp_casco_8,
                                               :esp_casco_9,
                                               :esp_casco_10,
                                               :esp_min_corpo,
                                               :esp_min_tampo)
      end

    def get_relacoes        
        # @proprietarias = Cadastro.order(:nome_curto)        
        @users = User.order(:nome).order(:sobrenome)
        @vasos = Vaso.includes(:fabricante).order(:num_serie)
        @inspetoras = Cadastro.where(eh_empresa_inspetora: true).order(:nome_curto)      
        @instrumento_padraos = InstrumentoPadrao.all.order(:nome_curto)
    end 
    
    def set_espessura_vaso
        @espessura_vaso = EspessuraVaso.find(params[:id])
    end
end
