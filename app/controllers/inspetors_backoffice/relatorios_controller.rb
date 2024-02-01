class InspetorsBackoffice::RelatoriosController < InspetorsBackofficeController
    before_action :set_relatorio, only: [:edit, :update, :destroy]
    before_action :get_relacoes, only: [:new, :edit]

    def index
        @inspecoes_andamento = Relatorio.relatorios_em_aberto_inspetor(current_inspetor.id, params[:page])
        @nome_rel = 'em Aberto'
        #@proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
        #@em_aberto = TRUE
    end
    
    def new    
        @relatorio = Relatorio.new
    end

    def edit # Ação de edição        
    end

    def create      
        @relatorio = Relatorio.new(params_relatorio)    
        if @relatorio.save   
            redirect_to inspetors_backoffice_relatorios_path, notice: "Relatório criado com sucesso!"
        else
            get_relacoes
            render :new
        end
    end

    def update        
        if @relatorio.update(params_relatorio)
            redirect_to inspetors_backoffice_relatorio_path, notice: "Relatório atualizado com sucesso!"
        else
            get_relacoes
            render :edit
        end
    end

    def destroy
        if @relatorio.destroy
          redirect_to inspetors_backoffice_relatorios_path, notice: "Relatório excluído com sucesso!"
        else
          render :index
        end
    end

  ##########
  # PRIVATE
  ##########
  private
    def set_relatorio
      @relatorio = Relatorio.find(params[:id])      
    end
   
    def params_relatorio
        params.require(:relatorio).permit(:tipo_inspecao_id,
                                          :cidade_id,
                                          :data_relatorio,
                                          :vaso_id,
                                          :finalidade_vaso_id,
                                          :proprietaria_id,
                                          
                                          # Verificações iniciais
                                          :tipo_apresenta_sinais_reparo,
                                          :reparos_observados,
                                          :tipo_fixacao_vaso,
                                          :tipo_houve_alteracao_local_instalacao,
                                          :b_vaso_inativo_mais_doze_meses,
                                          :tipo_acesso_interno,
                                          :possui_acesso_visual_externo,
                                        
                                          # Inspeções contratadas
                                          :insp_contratada_vaso_inicial,
                                          :insp_contratada_vaso_reconstituicao_prontuario,
                                          :insp_contratada_vaso_externa,
                                          :insp_contratada_vaso_interna,
                                          :insp_contratada_vaso_teste_hidrostatico,
                                          :insp_contratada_vaso_mapa_espessura,
                                          :insp_contratada_valvsegpop_externa,
                                          :insp_contratada_valvsegpop_interna,
                                          :serv_contratado_dispseg_calibracao,
                                          :insp_pressostato,
                                          :insp_manometro,
                                          :insp_dreno,
                                          :insp_contratada_vaso_paradaretorno_operacao,
                                          
                                          # Inspeção das instalações
                                          :bpossui_placa_dolocal_deinstalacao,
                                          :ambiente_inst_id,
                                          :tipo_cobetura,
                                          :bdispoe_duassaidas_amplas_sinalizadas_desobstruidas,
                                          :bdispor_acesso_facil_seguro_paraoperacao_manutencao,
                                          :bdispor_ventilacao_permanente,
                                          :bdispor_iluminacao_artificial,
                                          :bpossui_iluminacao_emergencia,
                                          :belementos_facilmente_acessiveis_drenosrespiroseoutros,
                                          
                                          # Inspeção do manômetro
                                          :bpossui_manometro_ousimilar,
                                          :bman_foi_substituido,
                                          :bmanometro_ehmantido_calibrado_eemboas_condicoes_operacao,
                                          :manometro_observacoes,
                                          
                                          # Inspeção do dispositivo de segurança
                                          :possui_dispositivo_deseguranca,
                                          :bBloqueioInadvertidoIntencionalDoDispSeg,
                                          :bdispseg_foisubstituido,
                                          :dispositivoseg_observacoes,
                                          :dispositivoseg_pabertura,
                                          
                                          # Inspeção do pressostato
                                          :bpressostato_existe,
                                          :bpressostato_ehmantido_calibrado_eemboas_condicoes_operacao,
                                          :bpressostato_foisubstituido,
                                          :bpressostato_foiverificada_faixadetrabalho,
                                          :pressostato_pliga,
                                          :pressostato_pdesliga,
                                          :pressostato_observacoes,
                                          
                                          # Inspeção no dreno
                                          :bdreno_existe,
                                          :tipo_dreno_id,
                                          :bdreno_posicionado_ptomais_baixo,
                                          :bdreno_inclinacao_positiva,
                                          :bajuste_inclinacao,
                                          :bdreno_foisubstituido,
                                          :bdreno_foiacionado_paradrenar_liqacumulado,
                                          :dreno_qtdadeliquido_drenado,
                                          :dreno_observacoes,
                                          
                                          # Vaso e outros
                                          # vaso
                                          :bpintura_emboas_condicoes,
                                          :bexiste_deformacoes_trincas_vazamentos_vaso,
                                          :bexiste_corrosaoacentuada_trincas_oupartes_soltas,
                                          :bexiste_falha_nasolda_entreberco_ecasco_dovaso,
                                          :bexiste_corrosao_outrincas_noselementos_fixacao,
                                          # outros
                                          :baspartes_moveis_estao_protegidas,                                        
                                          :basconexoes_eacessorios_estao_emboas_condicoesfisicas,
                                          :basconexoes_acessorios_apresentamvazamentos,
                                          
                                          # Fotos
                                          # inspeção externa
                                          :foto_antes_inspecao,
                                          :foto_pos_inspecao,
                                          :foto_corpo,
                                          :foto_instalacao,
                                          # teste hidrostático
                                          :foto_th,
                                          # inspeção interna                                          
                                          :foto_interna1,
                                          :foto_interna2,
                                          :foto_interna3,
                                          :foto_interna4,
                                    )
    end
    
    def get_relacoes
      #@fabricantes        = Cadastro.where(eh_fabricante: true).order(:nome_curto)      
      #@proprietarias      = Cadastro.order(:nome_curto)
      #@catnr13s           = Catnr13.order(:id)
      #@tipo_compressors   = TipoCompressor.order(:tipo_compressor)      
      #@relatorio_inis     = Relatorio.order(:id)
      #@tipo_vasos         = TipoVaso.order(:tipo_vaso)
      #@codigo_construcaos = CodigoConstrucao.order(:codigo)
      #@fluido_servicos    = FluidoServico.order(:descricao)
      #@potencial_riscos   = PotencialRisco.order(:descricao)
      #@classe_fluidos     = ClasseFluido.order(:descricao)
      #@tipo_dispositivo_segurancas = TipoDispositivoSeguranca.order(:descricao)
      #@materials          = Material.order(:descricao)
      #@users              = User.order(:nome).order(:sobrenome)
      @tipo_inspecaos     = TipoInspecao.order(:nome)
      #@arts               = Art.includes(:cadastro).order(id: :desc)
      #@phs                = Ph.order(:nome)
      @cidades            = Cidade.order(:nome)
      @vasos              = Vaso.includes(:fabricante).order(:num_serie)
      @finalidade_vasos   = FinalidadeVaso.all
      @proprietarias      = Cadastro.order(:nome_curto)
      #@inspetoras         = Cadastro.where(eh_empresa_inspetora: true).order(:nome_curto)      
      @ambiente_insts     = AmbienteInst.order(:ambiente)
    end
  
end    
