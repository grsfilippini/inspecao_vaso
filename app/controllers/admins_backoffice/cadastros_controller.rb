class AdminsBackoffice::CadastrosController < AdminsBackofficeController
    before_action :set_cadastro, only: [:edit, :update, :destroy]
    before_action :get_cidades_corps, only: [:new, :edit]
    
    def index
      # O includes abaixo inclui na query a busca por cadastro_corp
      # Se não for usado, e usar diretamente na view da index, ele fará a cada cadastro uma nova query para buscar a corporação
      @cadastros = Cadastro.includes(:corp)
                           .all
                           .order(:nome_curto)
                           .page(params[:page])
                           .per(50)
    end
  
    def new
      @cadastro = Cadastro.new      
    end
  
    def create
      @cadastro = Cadastro.new(params_cadastro)
      if @cadastro.save
        redirect_to admins_backoffice_cadastros_path, notice: "Cadastro criado com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @cadastro.update(params_cadastro)
        redirect_to admins_backoffice_cadastros_path, notice: "Cadastro atualizado com sucesso!"    
      else
        render :edit
      end
    end
  
    def destroy
      if @cadastro.destroy
        redirect_to admins_backoffice_cadastros_path, notice: "Cadastro excluído com sucesso!"    
      else
        render :index
      end
    end
  
  
    private
  
    
    def params_cadastro
      puts params
      params.require(:cadastro).permit(:id, :nome, :nome_curto, :cnpj, :cidade, :endereco, :cep, :email, :fone, :contato, :website, :observacoes, :eh_fabricante, :bairro, :eh_empresa_inspetora, :regiao, :corp_id, :numero)
    end
  
    def set_cadastro
      @cadastro = Cadastro.find(params[:id])
    end

    def get_cidades_corps
      @cidades = Cidade.all
      @corps = Corp.all
    end
  
  end
  