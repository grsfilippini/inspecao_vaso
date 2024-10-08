class InspetorsBackoffice::VasosController < InspetorsBackofficeController
    before_action :get_relacoes, only: [:new, :edit]
    before_action :set_vaso, only: [:edit, :update, :destroy]

    def index
        # O includes abaixo inclui na query a busca por cadastro_corp
        # Se não for usado, e usar diretamente na view da index, ele fará a cada cadastro uma nova query para buscar a corporação
        @vasos = Vaso.includes(:proprietaria,  :fabricante)
                     .all
                     .order(rascunho: :desc, num_serie: :asc)
                     .page(params[:page])
                     .per(50)
    end


    def new
        @vaso = Vaso.new
        #Vaso.foto_plaqueta_aux = nil     
    end
    
    def create      
      @vaso = Vaso.new(params_vaso)
      # @vaso.uploaded_foto_plaqueta = params[:vaso][:foto_plaqueta] if params[:vaso][:foto_plaqueta].present?
      # @vaso.process_uploaded_foto_plaqueta
      #Vaso.foto_plaqueta_aux = params[:vaso][:foto_plaqueta] if params[:vaso][:foto_plaqueta].present?

      #@vaso.foto_plaqueta = params[:vaso][:foto_plaqueta].read if params[:vaso][:foto_plaqueta].present?
      # Atribui a foto ao modelo @vaso
      # if params[:vaso][:foto_plaqueta].present?
      #   @vaso.foto_plaqueta = params[:vaso][:foto_plaqueta].read
      # end
      if params[:vaso][:proximomtp] == "1"
        # Resgata o próximo número de série disponível e atribui ao dispositivo de segurança                
        @vaso.num_serie = obter_ultima_serie_mtp_hash        
      end      

      # Salva o novo vaso
      # Para o inspetor, a pmta_atual será igual a original
      #                  o lançamento ficará no modo rascunho
      @vaso.pmta_atual = @vaso.pmta_original
      @vaso.pth_atual  = @vaso.pth_original
      #puts '***************************'        
      #puts @vaso.pmta_atual
      #puts @vaso.pmta_original
      @vaso.rascunho = true
      
      if @vaso.save  
        if params[:vaso][:foto_plaqueta].present?
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @vaso.update_attribute(:foto_plaqueta, params[:vaso][:foto_plaqueta].read)
          #@vaso.update_attribute(:foto_plaqueta, Vaso.foto_plaqueta_aux.read)
        end
          #puts '***************************'        
          #puts params
          #puts '***************************'
          #puts params[:vaso]
        if params[:vaso][:proximomtp] == "1"          
          @mtp_serie = MtpNumSerie.new
          @mtp_serie.serie = @vaso.num_serie
          @mtp_serie.vaso_id = @vaso.id
          @mtp_serie.save          
        end
        
        redirect_to inspetors_backoffice_vasos_path, notice: "Vaso criado com sucesso!"        
      else
        get_relacoes
        #@uploaded_file_foto_plaqueta = params[:vaso][:foto_plaqueta]
        @vaso.foto_plaqueta = nil
        render :new
      end
    end
    
    
    def edit # Ação de edição    
      #Vaso.foto_plaqueta_aux = nil   
    end
  

    def update 
      if @vaso.update(params_vaso)
        if params[:vaso][:foto_plaqueta].present?          
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @vaso.update_attribute(:foto_plaqueta, params[:vaso][:foto_plaqueta].read)
        end
        redirect_to inspetors_backoffice_vasos_path, notice: "Vaso atualizado com sucesso!"    
      else
        get_relacoes
        render :edit
      end
    end


    def pesquisa
        @vasos = Vaso.pesquisa_serie(params[:page], params[:num_serie])
    end

    def destroy
        if @vaso.destroy
          redirect_to inspetors_backoffice_vasos_path, notice: "Vaso excluído com sucesso!"
        else
          # render :index
          redirect_to inspetors_backoffice_vasos_path, alert: @vaso.errors.full_messages.to_sentence
        end
    end

    # Retorna um hash
    def obter_ultima_serie_mtp_hash
        last_record = MtpNumSerie.where("serie LIKE ?", "MTP%").order(serie: :desc).first
        #puts 'last_record.serie'
        #puts last_record.serie
        serie = last_record&.serie || 'MTP000' # Caso não haja registro, define um valor padrão vazio
        serie = last_record.serie[-3..-1]
        #puts 'serie'
        #puts serie
        next_serie_val = serie.to_i + 1      
        #puts 'next_serie_val'
        #puts next_serie_val
        serie = 'MTP'+ next_serie_val.to_s.rjust(3, '0')
        #puts 'serie'
        #puts serie
        serie
    end

    # Retorna u json
    def obter_ultima_serie_mtp
        serie = obter_ultima_serie_mtp_hash
        render json: { serie: serie }
    end

    def json_data      
      @vaso = Vaso.find(params[:id])
      render json: { pmta_atual: @vaso.pmta_atual, proprietaria_id: @vaso.proprietaria_id }
    end

    private

    def set_vaso
      @vaso = Vaso.find(params[:id])      
    end

    def params_vaso
        params.require(:vaso).permit(:foto_plaqueta,
                                     :fabricante_id,
                                     :num_serie,
                                     :dt_fabricacao_reconstituicao,
                                     :bsem_data_fabricacao,
                                     :tipo_compressor_id,
                                     :volume,
                                     :proprietaria_id,
                                     :tipo_dreno_id,                                     
                                     :observacoes,
                                     :tipo_vaso_id,                                     
                                     :tipo_dispositivo_seguranca_id, 
                                     :pmta_original,
                                     :pth_original,                                    
                                     :perimetro_diametro_externo,
                                     :entre_soladas_corpo,
                                     :profundidade_tampo,
                                     :setor_instalacao_vaso,
                                     :diametro_externo_corpo,
                                     :tag_proprietaria
                                    )
      end

      def get_relacoes
        @fabricantes        = Cadastro.where(eh_fabricante: true).order(:nome_curto)      
        @proprietarias      = Cadastro.order(:nome_curto)
        @tipo_vasos         = TipoVaso.order(:tipo_vaso)
        @tipo_dispositivo_segurancas = TipoDispositivoSeguranca.order(:descricao)
        @tipo_compressors   = TipoCompressor.order(:tipo_compressor)
        @tipo_drenos        = TipoDreno.order(:tipo_dreno)
      end      

end
