class AdminsBackoffice::InstrumentoPadraosController < AdminsBackofficeController
    before_action :set_instrumento_padrao, only: [:edit, :update, :destroy]
    
    def index
      @instrumento_padraos = InstrumentoPadrao.all.order(:nome_curto).page(params[:page]).per(10)
    end
  
    def new
      @instrumento_padrao = InstrumentoPadrao.new
    end
  
    def create
      @instrumento_padrao = InstrumentoPadrao.new(params_instrumento_padrao)
      if @instrumento_padrao.save
        redirect_to admins_backoffice_instrumento_padraos_path, notice: "Instrumento criado com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @instrumento_padrao.update(params_instrumento_padrao)
        redirect_to admins_backoffice_instrumento_padraos_path, notice: "Instrumento atualizado com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @instrumento_padrao.destroy
        redirect_to admins_backoffice_instrumento_padraos_path, notice: "Instrumento excluído com sucesso!"
      else
        render :index
      end
    end
  
 
    private
  
    
    def params_instrumento_padrao
      puts params
      params.require(:instrumento_padrao).permit(:id, :descricao, :nome_curto)
    end
  
    def set_instrumento_padrao
      # Resgata o registro passado em id, para dentro da variável admin
      @instrumento_padrao = InstrumentoPadrao.find(params[:id])
    end
  
end
