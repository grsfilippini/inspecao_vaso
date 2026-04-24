class AdminsBackoffice::EspessuraVasosController < AdminsBackofficeController    
    
    include SharedMethods

    before_action :set_espessura_vaso, only: [:edit, :update, :destroy, :avaliarph]    
    before_action :get_relacoes, only: [:new, :edit]
    
    require "zip"
    
    def index
        @espessura_vasos = EspessuraVaso.pesquisa(params[:page], nil, nil, false, true)
        @proprietarias = Cadastro.order(:nome_curto)
    end

    def impressos        
        @espessura_vasos = EspessuraVaso.pesquisa(params[:page], params[:num_serie], params[:proprietaria_id], false, true)
        @proprietarias = Cadastro.order(:nome_curto)
    end

    def em_aberto
        @espessura_vasos = EspessuraVaso.pesquisa(params[:page], params[:num_serie], params[:proprietaria_id], true, false)                
        @proprietarias = Cadastro.order(:nome_curto)
    end

    def a_imprimir        
        @espessura_vasos = EspessuraVaso.pesquisa(params[:page], params[:num_serie], params[:proprietaria_id], false, false)
        @proprietarias = Cadastro.order(:nome_curto)        
    end

    def new
        @espessura_vaso = EspessuraVaso.new
    end  
    
    def create
        @espessura_vaso = EspessuraVaso.new(params_espessura_vaso)
        if @espessura_vaso.save
          redirect_to admins_backoffice_espessura_em_aberto_path, notice: "Espessura de vaso criada com sucesso!"
        else
          get_relacoes
          render :new
        end
    end

    def edit
    end

    def update
        if @espessura_vaso.update(params_espessura_vaso)
        
            Rails.logger.debug "ORIGEM = #{params[:origem]}"
            
            case params[:origem]
            when "impressos"
            redirect_to admins_backoffice_espessura_impressos_path,
                        notice: "Atualizado com sucesso!"
        
            when "em_aberto"
            redirect_to admins_backoffice_espessura_em_aberto_path,
                        notice: "Atualizado com sucesso!"
        
            when "a_imprimir"
            redirect_to admins_backoffice_espessura_a_imprimir_path,
                        notice: "Atualizado com sucesso!"
        
            else
            redirect_to admins_backoffice_espessura_vasos_path,
                        notice: "Atualizado com sucesso!"
            end
        
        else
            get_relacoes
            render :edit
        end
    end

    def destroy
        if @espessura_vaso.destroy
            redirect_to admins_backoffice_espessura_em_aberto_path, notice: "Espessura vaso excluída com sucesso!"
        else
            render :index
        end
    end

    def avaliarph        
        get_relacoes        
    end

    def marcar_como_impresso
        @espessura_vaso = EspessuraVaso.find(params[:id])
        @espessura_vaso.update(bimpresso: true)
        
        redirect_back fallback_location: admins_backoffice_espessura_a_imprimir_path,
                        notice: "Registro marcado como impresso."
    end

    def imprime_espessura      
      @espessura_vaso = EspessuraVaso.find(params[:id])      
      @vaso = @espessura_vaso.vaso
      
      respond_to do |format|
        format.html{          
        }
        
        format.pdf do      
          if params[:b_assinar] == 'false'
            render template: 'admins_backoffice/espessura_vasos/imprime_espessura_pdf',
                    pdf: 'espessura_vaso',
                    locals: { asset_path: "#{Rails.root.join('app/assets/images')}" },
                    disposition: 'inline',
                    layout: 'pdf.html',
                    page_size: 'A4'
          else
            path_doc_assinado = gera_pdf_empresa_equipamento_assinado(current_admin, @espessura_vaso.vaso.proprietaria, @espessura_vaso.vaso, "admins_backoffice/espessura_vasos/imprime_espessura_pdf", "espessura_vaso_assinado.pdf", "pdf.html", "Portrait")
            send_file path_doc_assinado, type: 'application/pdf', disposition: 'attachment'
          end

        end
      end
    end

    def ajustar_memorial
        vaso_id = params[:vaso_id]
      
        template_path = Rails.root.join("lib", "templates", "memorial_rails.ods")
        output_path   = Rails.root.join("tmp", "memorial_vaso_#{vaso_id}.ods")
      
        FileUtils.cp(template_path, output_path)
      
        Zip::File.open(output_path) do |zip|
          entry = zip.glob("content.xml").first
          content = entry.get_input_stream.read
      
          # substituição exemplo
          content.gsub!("ID_VASO_PLACEHOLDER", vaso_id.to_s)
      
          zip.get_output_stream("content.xml") { |f| f.write(content) }
        end
      
        send_file output_path,
            filename: "memorial_vaso_#{vaso_id}.ods",
            type: "application/vnd.oasis.opendocument.spreadsheet",
            disposition: "attachment"
    end


    private
    

    def params_espessura_vaso        
        params.require(:espessura_vaso).permit(:b_rascunho,
                                               :bimpresso,
                                               :user_id, 
                                               :vaso_id,
                                               :data,
                                               :instrumento_padrao_id,
                                               :inspetora_id,                                               
                                               :esp_casco_1,
                                               :esp_casco_2,
                                               :esp_casco_3,
                                               :esp_casco_4,
                                               :esp_casco_5,
                                               :esp_casco_6,
                                               :esp_casco_7,
                                               :esp_casco_8,
                                               :esp_casco_9,
                                               :esp_casco_10,
                                               :esp_min_corpo,
                                               :esp_min_tampo)
      end

    def get_relacoes        
        # @proprietarias = Cadastro.order(:nome_curto)        
        @users = User.order(:nome).order(:sobrenome)
        @vasos = Vaso.includes(:fabricante).order(:num_serie)
        @inspetoras = Cadastro.where(eh_empresa_inspetora: true).order(:nome_curto)      
        @instrumento_padraos = InstrumentoPadrao.all.order(:nome_curto)
    end 
    
    def set_espessura_vaso
        @espessura_vaso = EspessuraVaso.find(params[:id])
    end

end
