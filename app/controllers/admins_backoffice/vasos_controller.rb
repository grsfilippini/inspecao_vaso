class AdminsBackoffice::VasosController < AdminsBackofficeController
    before_action :set_vaso, only: [:edit, :update, :destroy]
    before_action :get_relacoes, only: [:new, :edit]
    after_action :get_relacoes_cad_corp, only: [:index, :pesquisa]
    
    def index
      # O includes abaixo inclui na query a busca por cadastro_corp
      # Se não for usado, e usar diretamente na view da index, ele fará a cada cadastro uma nova query para buscar a corporação
      @vasos = Vaso.includes(:proprietaria,  :fabricante, :user)
                   .all
                   .order(:num_serie)
                   .page(params[:page])
                   .per(100)
      @proprietarios = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
      @corps = Corp.all.order(:nome)
    end
  
    def new
      @vaso = Vaso.new     
    end
  
    def create      
      @vaso = Vaso.new(params_vaso)
      
      if params[:vaso][:proximomtp] == "1"
        # Resgata o próximo número de série disponível e atribui ao dispositivo de segurança                
        @vaso.num_serie = obter_ultima_serie_mtp_hash        
      end      

      # Salva o novo dispositivo de segurança
      if @vaso.save
        if params[:vaso][:foto_plaqueta].present?
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @vaso.update_attribute(:foto_plaqueta, params[:vaso][:foto_plaqueta].read)
        end

        if params[:vaso][:foto_instalacao].present?
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @vaso.update_attribute(:foto_instalacao, params[:vaso][:foto_instalacao].read)
        end

        if params[:vaso][:proximomtp] == "1"          
          @mtp_serie = MtpNumSerie.new
          @mtp_serie.serie = @vaso.num_serie
          @mtp_serie.vaso_id = @vaso.id
          @mtp_serie.save          
        end
        
        redirect_to admins_backoffice_vasos_path, notice: "Vaso criado com sucesso!"        
      else
        get_relacoes
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update 
      # Verifica se veio o flag para remover foto da plaqueta.      
      bRemoverFoto = (params[:vaso][:remove_foto_plaqueta] == '1' || params[:vaso][:remove_foto_plaqueta] == 'true')
      bRemoverFotoInstalacao = (params[:vaso][:remove_foto_instalacao] == '1' || params[:vaso][:remove_foto_instalacao] == 'true') 
      
      # Remover o atributo específico dos parâmetros caso exista.
      # Isto é feito para que o update adiante não gere erro.
      params[:vaso].delete(:remove_foto_plaqueta) if params[:vaso].key?(:remove_foto_plaqueta)
      params[:vaso].delete(:remove_foto_instalacao) if params[:vaso].key?(:remove_foto_instalacao)

      if @vaso.update(params_vaso)
        # Verificar se um novo arquivo de imagem foi enviado
        
        if params[:vaso][:foto_plaqueta].present?          
            # Atualizar o campo de imagem diretamente com o novo arquivo
            @vaso.update_attribute(:foto_plaqueta, params[:vaso][:foto_plaqueta].read)
        elsif bRemoverFoto
            # Atualizar o campo de imagem - sem imagem
            @vaso.update_attribute(:foto_plaqueta, nil)          
        end

        if params[:vaso][:foto_instalacao].present?          
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @vaso.update_attribute(:foto_instalacao, params[:vaso][:foto_instalacao].read)
        elsif bRemoverFotoInstalacao
          # Atualizar o campo de imagem - sem imagem
          @vaso.update_attribute(:foto_instalacao, nil)          
      end

        redirect_to admins_backoffice_vasos_path, notice: "Vaso atualizado com sucesso!"    
      else
        get_relacoes
        render :edit
      end
    end
  
    def destroy
      if @vaso.destroy
        redirect_to admins_backoffice_vasos_path, notice: "Vaso excluído com sucesso!"    
      else
        render :index
      end
    end
  
    #def PlaquetaPreview
    #  @vaso = Vaso.find(params[:id])
    #  send_data @vaso.foto_plaqueta, type: 'image/jpeg', disposition: 'inline'
    #end
    
    def pesquisa
      # O includes abaixo inclui na query a busca por cadastro_corp
      # Se não for usado, e usar diretamente na view da index, ele fará a cada cadastro uma nova query para buscar a corporação
      @vasos = Vaso.pesquisa_serie_prop(params[:page], params[:num_serie], params[:proprietaria_id], params[:corp_id])
      #@vasos = Vaso.all.page(params[:page]).per(10)
      
      @proprietarios = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
      @corps = Corp.all.order(:nome)
    end
    
    def json_data      
      @vaso = Vaso.find(params[:id])
      render json: { pmta_atual: @vaso.pmta_atual, proprietaria_id: @vaso.proprietaria_id }
    end

    # Retorna um hash
    def obter_ultima_serie_mtp_hash
      last_record = MtpNumSerie.where("serie LIKE ?", "MTP%").order(serie: :desc).first
      serie = last_record&.serie || 'MTP000' # Caso não haja registro, define um valor padrão vazio
      serie = last_record.serie[-3..-1]
      next_serie_val = serie.to_i + 1      
      serie = 'MTP'+ next_serie_val.to_s.rjust(3, '0')
      serie
    end

    # Retorna u json
    def obter_ultima_serie_mtp
      serie = obter_ultima_serie_mtp_hash
      render json: { serie: serie }
    end
    
    def get_vasos_by_proprietaria
      proprietaria_id = params[:proprietaria_id]
      vasos = Vaso.where(proprietaria_id: proprietaria_id).order(:num_serie)
      render json: vasos.select(:id, :num_serie).as_json
    end

    # Método para remover a foto do vaso
    # def remove_photo
    #   @vaso = Vaso.find(params[:id])
    #   @vaso.foto_plaqueta = nil # Define o atributo foto_plaqueta como nil para remover a foto
    #   @vaso.save
    #   redirect_to edit_admins_backoffice_vaso_path(@vaso), notice: 'Foto da plaqueta removida com sucesso!'
    # end    

    ##########
    # PRIVATE
    ##########
    private
   
    def params_vaso
      params.require(:vaso).permit(:fabricante_id,
                                   :num_serie,
                                   :catnr13_id,
                                   :dt_fabricacao_reconstituicao,
                                   :tipo_compressor_id,
                                   :volume,
                                   :proprietaria_id,
                                   :tipo_dreno_id,
                                   :p_inf_operacao_fabricante,
                                   :p_sup_operacao_fabricante,
                                   :pmta_original,
                                   :pth_original,
                                   :pmta_atual,
                                   :pth_atual,
                                   :observacoes,
                                   :relatorio_ini_id,
                                   :tipo_vaso_id,
                                   :p_projeto,
                                   :codigo_construcao_id,
                                   :bsem_data_fabricacao,
                                   :data_instalacao,
                                   :fluido_servico_id,
                                   :potencial_risco_id,
                                   :classe_fluido_id,
                                   :tipo_dispositivo_seguranca_id,
                                   :disp_seguranca_id,
                                   :temp_min_prj,
                                   :temp_max_prj,
                                   :material_id,
                                   :efic_solda_tampo,
                                   :efic_solda_costado,
                                   :efic_solda_costado_tampo,
                                   :perimetro_diametro_externo,
                                   :entre_soladas_corpo,
                                   :profundidade_tampo,
                                   :esp_projeto_corpo,
                                   :esp_projeto_tampo,
                                   :setor_instalacao_vaso,
                                   :foto_plaqueta,
                                   :diametro_externo_corpo,
                                   :user_id,
                                   :tag_proprietaria,
                                   :foto_instalacao
                                  )
    end
  
    def set_vaso
      @vaso = Vaso.find(params[:id])
    end
    
    def get_relacoes
      @fabricantes        = Cadastro.where(eh_fabricante: true).order(:nome_curto)      
      @proprietarias      = Cadastro.order(:nome_curto)
      @catnr13s           = Catnr13.order(:id)
      @tipo_compressors   = TipoCompressor.order(:tipo_compressor)
      @tipo_drenos        = TipoDreno.order(:tipo_dreno)
      @relatorio_inis     = Relatorio.order(:id)
      @tipo_vasos         = TipoVaso.order(:tipo_vaso)
      @codigo_construcaos = CodigoConstrucao.order(:codigo)
      @fluido_servicos    = FluidoServico.order(:descricao)
      @potencial_riscos   = PotencialRisco.order(:descricao)
      @classe_fluidos     = ClasseFluido.order(:descricao)
      @tipo_dispositivo_segurancas = TipoDispositivoSeguranca.order(:descricao)
      @materials          = Material.order(:descricao)
      @users              = User.order(:nome).order(:sobrenome)
    end
    
    def get_relacoes_cad_corp
      #@proprietarios = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
      #@corps = Corp.all.order(:nome)      
    end
    
end
  