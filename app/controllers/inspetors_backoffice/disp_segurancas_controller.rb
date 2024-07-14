class InspetorsBackoffice::DispSegurancasController < InspetorsBackofficeController
    before_action :set_disp_seguranca, only: [:edit, :update, :destroy]
    before_action :get_relacoes, only: [:new, :edit]

    def index
        @disp_segurancas = DispSeguranca.all
                                        .order(id: :desc)
                                        .page(params[:page])
                                        .per(50)

    end

    def new    
        @disp_seguranca = DispSeguranca.new
    end

    def create
        @disp_seguranca = DispSeguranca.new(params_disp_seguranca)   
        @disp_seguranca.user_id = 1   
        if params[:disp_seguranca][:proximomtpds] == "1"
          # Resgata o próximo número de série disponível e atribui ao dispositivo de segurança                
          @disp_seguranca.serie = obter_ultima_serie_mtpds_hash
        end      
        # Salva o novo dispositivo de segurança
        if @disp_seguranca.save        
          # Se é para considerar o próximo mtpds, então salva no controle MtpdsNumSerie
          
          if params[:disp_seguranca][:proximomtpds] == "1"
            @mtpds_serie = MtpdsNumSerie.new
            @mtpds_serie.serie = @disp_seguranca.serie
            @mtpds_serie.disp_seguranca_id = @disp_seguranca.id
            @mtpds_serie.save          
          end
          redirect_to inspetors_backoffice_disp_segurancas_path, notice: "Dispositivo de segurança criado com sucesso!"    
        else
          get_relacoes
          # Apaga número de série, pois o campo proximomtpds fica unckedked após erro de save.
          # Assim obriga o usuário a selecionar novamente o próximo num serie.
          @disp_seguranca.serie = ''
          render :new
        end
      end

      def edit # Ação de edição    
      end

      # Retorna u json
      def obter_ultima_serie_mtpds            
        serie = obter_ultima_serie_mtpds_hash
        render json: { serie: serie }
      end

    private

    def params_disp_seguranca
        params.require(:disp_seguranca).permit(:serie, :cadastro_id, :tipo_dispositivo_seguranca_id, :castelo, :bitola)
    end

    def set_disp_seguranca
        @disp_seguranca = DispSeguranca.find(params[:id])
    end

    def get_relacoes
        @cadastros = Cadastro.where(eh_fabricante: TRUE).order(:nome_curto)      
        @tipo_dispositivo_segurancas = TipoDispositivoSeguranca.order(:nome)
    end

    # Retorna um hash
    def obter_ultima_serie_mtpds_hash
      last_record = MtpdsNumSerie.where("serie LIKE ?", "MTPDS%").order(serie: :desc).first
      serie = last_record&.serie || 'MTPDS0000' # Caso não haja registro, define um valor padrão vazio
      serie = last_record.serie[-4..-1]
      next_serie_val = serie.to_i + 1      
      serie = 'MTPDS'+ next_serie_val.to_s.rjust(4, '0')
      serie      
    end
    
end
