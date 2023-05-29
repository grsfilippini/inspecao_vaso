class AdminsBackoffice::UsersController < AdminsBackofficeController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :verify_password, only: [:update]
    
  def index    
    @users = User.all.order(:nome, :sobrenome).page(params[:page]).per(10)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params_user)
    if @user.save
      redirect_to admins_backoffice_users_path, notice: "Usuário criado com sucesso!"
    else
      render :new
    end
  end

  def edit
  end
  
  def update        
    if @user.update(params_user)      
      redirect_to admins_backoffice_users_path, notice: "Usuário atualizado com sucesso!"    
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admins_backoffice_users_path, notice: "Usuário excluído com sucesso!"    
    else
      render :index
    end
  end

  private
  
  def params_user    
    params.require(:user).permit(:nome, :sobrenome, :email, :password, :password_confirmation,
                                 perfil_usuario_attributes: [:id, :endereco, :sexo, :aniversario, :avatar])
  end
  
  def set_user
    @user = User.find(params[:id])
  end

  def verify_password
    # Caso não tenha senha digitada, nem conf. de senha, elimina estas do :admin para não dar erro ao salvar se senha e/ou conf. de senha
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].extract!(:password, :password_confirmation)
    end
  end    
  
end
