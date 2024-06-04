class AdminsBackoffice::CadastrosController < AdminsBackofficeController
    before_action :set_cadastro, only: [:edit, :update, :destroy]
    before_action :get_cidades_corps, only: [:new, :edit]
    
    def index
      # O includes abaixo inclui na query a busca por cadastro_corp
      # Se não for usado, e usar diretamente na view da index, ele fará a cada cadastro uma nova query para buscar a corporação
      @mostrar_botao_pdf = TRUE
      respond_to do |format|
        format.html{
          @cadastros = Cadastro.includes(:corp, :user)
                               .all
                               .order(:nome_curto)
                               .page(params[:page])
                               .per(50)                           
          @corps = Corp.all.order(:nome)
        }
        #format.json
        format.pdf {
          @cadastros = Cadastro.includes(:corp, :user).all.order(:nome_curto)               
          @corps = Corp.all.order(:nome)
          render template: 'admins_backoffice/cadastros/relatorio', 
                 pdf: 'cadastro_relatorio', 
                 layout: 'pdf.html' 
        }
      end
    end
  
    def new
      @cadastro = Cadastro.new      
    end
  
    def create
      @cadastro = Cadastro.new(params_cadastro)
      if @cadastro.save
        redirect_to admins_backoffice_cadastros_path, notice: "Cadastro criado com sucesso!"    
      else
        get_cidades_corps
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @cadastro.update(params_cadastro)
        redirect_to admins_backoffice_cadastros_path, notice: "Cadastro atualizado com sucesso!"    
      else
        get_cidades_corps
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
  
    def pesquisa
      @mostrar_botao_pdf = FALSE
      respond_to do |format|
        format.html{          
          @cadastros = Cadastro.pesquisa_nome_corp(params[:page], params[:termo_nome], params[:corp_id])      
          @corps = Corp.all.order(:nome)
        }
        format.pdf{
          @cadastros = Cadastro.pesquisa_nome_corp_pdf(params[:termo_nome], params[:corp_id])
          @corps = Corp.all.order(:nome)
          render template: 'admins_backoffice/cadastros/pesquisa', 
                 pdf: 'pesquisa_cadastro_relatorio', # Excluding ".pdf" extension.
                 disposition: 'inline', # Valor default, se usar attachment, irá abrir um popup para salvar o pdf
                 layout: 'pdf.html',
                 page_size: 'A4'
        }
      end
    end
  
    def imprime_cadastro
      respond_to do |format|      
        format.html{
          #@cadastro = Cadastro.find(params[:id])
        }
      end
    end

    # def pesquisa      
    #   @cadastros = Cadastro.pesquisa_nome_corp(params[:page], params[:termo_nome], params[:corp_id])
    #   @corps = Corp.all.order(:nome)
    #   render template: 'admins_backoffice/cadastros/relatorio', pdf: 'cadastro_relatorio'
      # @cadastros = Cadastro.pesquisa_nome_corp(params[:page], params[:termo_nome], params[:corp_id])
      # @corps = Corp.all.order(:nome)      
    # end
    
  
    private
  
    
    def params_cadastro
      #puts params
      params.require(:cadastro).permit(:nome,
                                       :nome_curto,
                                       :cnpj,
                                       :ie,
                                       :im,
                                       :cidade_id,
                                       :endereco,
                                       :cep,
                                       :email,
                                       :fone,
                                       :contato,
                                       :website,
                                       :observacoes,
                                       :eh_fabricante,
                                       :bairro,
                                       :eh_empresa_inspetora,
                                       :regiao,
                                       :corp_id,
                                       :numero,
                                       :user_id,
                                       :seq_roteiro)
    end
  
    def set_cadastro
      @cadastro = Cadastro.find(params[:id])
    end

    def get_cidades_corps
      @cidades = Cidade.all.order(:nome)
      @corps   = Corp.all.order(:nome)
      @users   = User.order(:nome).order(:sobrenome)
    end
  
  end
  