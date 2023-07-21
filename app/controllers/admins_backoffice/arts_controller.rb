class AdminsBackoffice::ArtsController < AdminsBackofficeController
    before_action :set_art, only: [:edit, :update, :destroy]
    before_action :get_relacoes, only: [:new, :edit]

    
    def index
      # O includes abaixo inclui na query a busca por art      
      @arts = Art.includes(:cadastro, :ph, :user)
                 .all
                 .order(id: :desc)
                 .page(params[:page])
                 .per(15)
    end
  
    def new
      @art = Art.new
    end
  
    def create
      @art = Art.new(params_art)
      if @art.save
        redirect_to admins_backoffice_arts_path, notice: "ART criada com sucesso!"    
      else
        get_relacoes
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @art.update(params_art)
        redirect_to admins_backoffice_arts_path, notice: "ART atualizada com sucesso!"    
      else
        get_relacoes
        render :edit
      end
    end
  
    def destroy
      if @art.destroy
        redirect_to admins_backoffice_arts_path, notice: "ART excluída com sucesso!"    
      else
        render :index
      end
    end
  
    def json_data      
      @art = Art.find(params[:id])
      render json: { cadastro_id: @art.cadastro_id, ph_id: @art.ph_id }
    end
    
    
    private
  
    
    def params_art
      params.require(:art).permit(:id, :art, :cadastro_id, :ph_id, :user_id)
    end
  
    def set_art
      @art = Art.find(params[:id])
    end
    
    def get_relacoes
      @cadastros = Cadastro.where(eh_fabricante: FALSE, eh_empresa_inspetora: FALSE).order(:nome_curto)      
      @phs       = Ph.order(:nome)
      @users     = User.order(:nome).order(:sobrenome)
    end
end