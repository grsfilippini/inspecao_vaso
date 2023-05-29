class UsersBackoffice::PerfilController < UsersBackofficeController
  # Este before_action é uma espécie de gatilho que auxilia na chamada de procedimentos
  # abaixo está dizendo: antes de chamar update, chame verify_password
  # assim não é necessário referenciar verify_password dentro de update (ou no início deste)
  before_action :verify_password, only: [:update]
  before_action :set_user
  
  def edit
    # Se não tiver perfil de usuário associado, cria um perfil virtual.
    @user.build_perfil_usuario if @user.perfil_usuario.blank?
  end
  
  # Para atualizar dados no registro de user
  # Responde apenas para HTML
  def update        
    # Faz o update no registro 
    if @user.update(params_user)
      # Se for bem sucedido, faz login novamente com a nova senha
      bypass_sign_in(@user)
      # Se form bem sucedido vai para o caminho especificado, no caso o index de backoffice admins
      unless params_user[:perfil_usuario_attributes][:avatar]        
        redirect_to users_backoffice_perfil_path, notice: "Usuário atualizado com sucesso!"
      end
    else
      # renderiza novamente o form de edição, chamando o procedimento edit (acima neste código)
      render :edit
    end
  end
  
  
  private
  def set_user
    @user = User.find(current_user.id)
  end
  
  def params_user    
    # Resgata os parâmetros enviados pela internet (formulário)
    # Deve-se permitir os campos desejados. Assim não serão aceitos campos extras (questão de segurança)
    params.require(:user).permit(:nome, :sobrenome, :email, :password, :password_confirmation,
                                 perfil_usuario_attributes: [:id, :endereco, :sexo, :aniversario, :avatar])
  end
   
  def verify_password
    # Caso não tenha senha digitada, nem conf. de senha, elimina estas do :admin para não dar erro ao salvar se senha e/ou conf. de senha
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].extract!(:password, :password_confirmation)
    end
  end  
end
