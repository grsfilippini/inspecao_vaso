class AdminsBackoffice::InspetorsController < AdminsBackofficeController
  before_action :set_inspetor, only: [:edit, :update, :destroy]
  before_action :verify_password, only: [:update]
    
  def index
    @inspetors = Inspetor.all.order(:nome).page(params[:page]).per(20)
  end

  def new
    @inspetor = Inspetor.new
  end
  
  def create
    @inspetor = Inspetor.new(params_inspetor)
    if @inspetor.save
      redirect_to admins_backoffice_inspetors_index_path, notice: "Inspetor criado com sucesso!"
    else
      render :new
    end
  end

  def edit
  end
  
  def update        
    if @inspetor.update(params_inspetor)      
      redirect_to admins_backoffice_inspetors_index_path, notice: "Inspetor atualizado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @inspetor.destroy
      redirect_to admins_backoffice_inspetors_index_path, notice: "Inspetor excluído com sucesso!"    
    else
      render :index
    end
  end

  private
  
  def params_inspetor
    params.require(:inspetor).permit(:nome, :email, :password, :password_confirmation)
  end
  
  def set_inspetor
    @inspetor = Inspetor.find(params[:id])
  end

  def verify_password
    # Caso não tenha senha digitada, nem conf. de senha, elimina estas do :admin para não dar erro ao salvar se senha e/ou conf. de senha
    if params[:inspetor][:password].blank? && params[:inspetor][:password_confirmation].blank?
      params[:inspetor].extract!(:password, :password_confirmation)
    end
  end      

end
