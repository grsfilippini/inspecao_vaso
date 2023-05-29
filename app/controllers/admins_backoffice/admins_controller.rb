class AdminsBackoffice::AdminsController < AdminsBackofficeController
  # Este before_action é uma espécie de gatilho que auxilia na chamada de procedimentos
  # abaixo está dizendo: antes de chamar update, chame verify_password
  # assim não é necessário referenciar verify_password dentro de update (ou no início deste)
  before_action :verify_password, only: [:update]
  # O mesmo gatilho é usado para set_admin
  before_action :set_admin, only: [:edit, :update, :destroy]
  
  def index
    # Libere a linha abaixo para aparecer um console de debuguer no navegador
    #console
    # Trata-se do web console
    # No código html, usar 
    #<%console%>
    
    # Variável de seção, @admins estará disponível na view index
    @admins = Admin.all.order(:nome).page(params[:page]).per(5)
  end

  # Para chegar aqui, precisamos de uma rota que nos traga até aqui
  # O new abaixo é apenas um gerador de objeto admin na memória, porém todo vazio
  def new
    @admin = Admin.new
  end

  # Ação que efetivamente cria o admin na tabela, ou seja, grava o admin criado em new
  def create
    @admin = Admin.new(params_admin)
    # Faz o create no registro com os parâmetros enviados na url
    if @admin.save
      # Se form bem sucedido vai para o caminho especificado, no caso o index de backoffice admins
      redirect_to admins_backoffice_admins_path, notice: "Administrador criado com sucesso!"    
    else
      # renderiza novamente o form de edição, chamando o procedimento edit (acima neste código)
      render :new
    end
  end


  # Para chegar nesta ação, é necessária uma rota que que traga até aqui
  def edit # Ação de edição    
  end

  # Para atualizar dados no registro de admin
  def update        
    # Faz o update no registro 
    if @admin.update(params_admin)
      # Chama o AdminMailer (Classe) no método alterou_email e envia na hora (deliver_now) o email padrão
      # definido em views/admin_mailer, tanto em html, como em texto
      AdminMailer.alterou_email(current_admin, @admin).deliver_now
      # Se for bem sucedido, faz login novamente com a nova senha
      sign_in(@admin, bypass: true)
      # Se for bem sucedido vai para o caminho especificado, no caso o index de backoffice admins
      redirect_to admins_backoffice_admins_path, notice: "Administrador atualizado com sucesso!"    
    else
      # renderiza novamente o form de edição, chamando o procedimento edit (acima neste código)
      render :edit
    end
  end

  def destroy
    # Destroi o registro na tabela
    if @admin.destroy
      # Se form bem sucedido vai para o caminho especificado, no caso o index de backoffice admins
      redirect_to admins_backoffice_admins_path, notice: "Administrador excluído com sucesso!"    
    else
      # renderiza novamente o form de edição, chamando o procedimento edit (acima neste código)
      render :index
    end
  end


  # Métodos privados, somente os métodos que estão neste arquivo podem chamar os métodos abaixo
  private

  
  def params_admin
    puts params
    # Resgata os parâmetros enviados pela internet (formulário)
    # Deve-se permitir os campos desejados. Assim não serão aceitos campos extras (questão de segurança)
    params.require(:admin).permit(:nome, :email, :password, :password_confirmation)
  end

  def set_admin
    # Resgata o registro passado em id, para dentro da variável admin
    @admin = Admin.find(params[:id])
  end

  def verify_password
    # Caso não tenha senha digitada, nem conf. de senha, elimina estas do :admin para não dar erro ao salvar se senha e/ou conf. de senha
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank? 
      params[:admin].extract!(:password, :password_confirmation)
    end
  end
end
