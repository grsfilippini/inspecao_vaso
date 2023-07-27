class AdminsBackoffice::EmpresasController < AdminsBackofficeController
  before_action :set_empresa, only: [:edit, :update, :destroy]
  before_action :verify_password, only: [:update]
  before_action :get_relacoes, only: [:new, :edit]
    
  def index    
    @empresas = Empresa.all.order(:nome).page(params[:page]).per(20)
  end
  
  def new
    @empresa = Empresa.new
  end
  
  def create
    @empresa = Empresa.new(params_empresa)
    if @empresa.save
      redirect_to admins_backoffice_empresas_path, notice: "Empresa criada com sucesso!"
    else
      render :new
    end
  end

  def edit
  end
  
  def update        
    if @empresa.update(params_empresa)      
      redirect_to admins_backoffice_empresas_path, notice: "Empresa atualizada com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @empresa.destroy
      redirect_to admins_backoffice_empresas_path, notice: "Empresa excluída com sucesso!"    
    else
      render :index
    end
  end

  private
  
  def params_empresa    
    params.require(:empresa).permit(:nome, :email, :password, :password_confirmation, :corp_id)
  end
  
  def set_empresa
    @empresa = Empresa.find(params[:id])
  end

  def verify_password
    # Caso não tenha senha digitada, nem conf. de senha, elimina estas do :admin para não dar erro ao salvar se senha e/ou conf. de senha
    if params[:empresa][:password].blank? && params[:empresa][:password_confirmation].blank?
      params[:empresa].extract!(:password, :password_confirmation)
    end
  end    
    
  def get_relacoes    
    @corps   = Corp.all    
  end

end
