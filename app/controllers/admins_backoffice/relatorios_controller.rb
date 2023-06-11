class AdminsBackoffice::RelatoriosController < AdminsBackofficeController
  before_action :get_relacoes, only: [:new, :edit]
  
  def index
    @relatorios = Relatorio.relatorios_concluidos(params[:page])
    @nome_rel = 'Concluídos'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
  end
  
  def para_imprimir
    @relatorios = Relatorio.relatorios_para_imprimir(params[:page])
    @nome_rel = 'para Impressão'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
  end
  
  def em_aberto
    @relatorios = Relatorio.relatorios_em_aberto(params[:page])
    @nome_rel = 'em Aberto (rascunho)'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
  end

  def pesquisa    
    @relatorios = Relatorio.pesquisa_serie_prop(params[:page], params[:num_serie], params[:proprietaria_id])
    @nome_rel = 'Concluídos (pesquisa)'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)    
  end
  
  def new
    @relatorio = Relatorio.new     
  end

  def create      
    @relatorio = Relatorio.new(params_relatorio)    
    if @relatorio.save
      redirect_to admins_backoffice_relatorios_path, notice: "Relatório criado com sucesso!"
    else
      get_relacoes
      render :new
    end
  end
  
  
  
  private
   
    def params_relatorio
      params.require(:relatorio).permit(:user_id,
                                        :b_rascunho,
                                        :tipo_inspecao_id,
                                        :art_id,
                                        :ph_id,
                                        :cidade_id,
                                        :data_relatorio,
                                        :vaso_id,
                                        :finalidade_vaso_id,
                                        :proprietaria_id,                                   
                                        :inspetora_id,
                                        
                                        :tipo_ambiente_instalacao_vaso_pressao,
                                        :tipo_acionamentodreno
                                        
                                   
    #t.integer "tipo_acesso_interno", default: 1, null: false
    #t.text "metodo_alternativo_exame_interno"
    #t.integer "tipo_apresenta_sinais_reparo", default: 0, null: false
    #t.text "reparos_observados"
    #t.integer "tipo_fixacao_vaso", default: 0, null: false
    #t.integer "tipo_houve_alteracao_local_instalacao", default: 0, null: false
    #t.boolean "possui_respiro", default: false, null: false
    #t.boolean "possui_indicador_nivel", default: false, null: false
    #t.boolean "possui_indicador_temperatura", default: false, null: false
    #t.boolean "insp_contratada_vaso_externa", default: true, null: false
    #t.boolean "insp_contratada_vaso_interna", default: false, null: false
    #t.boolean "insp_contratada_vaso_teste_hidrostatico", default: false, null: false
    #t.boolean "insp_contratada_vaso_mapa_espessura", default: false, null: false
    #t.boolean "insp_contratada_vaso_inicial", default: false, null: false
    #t.boolean "insp_contratada_vaso_problema_operacional", default: false, null: false
    #t.boolean "insp_contratada_vaso_alteracao_operacional", default: false, null: false
    #t.boolean "insp_contratada_vaso_alteracao_estrutural", default: false, null: false
    #t.boolean "insp_contratada_vaso_alteracao_reparo", default: false, null: false
    #t.boolean "insp_contratada_vaso_reconstituicao_prontuario", default: false, null: false
    #t.boolean "insp_contratada_vaso_paradaretorno_operacao", default: false, null: false
    #t.boolean "insp_contratada_vaso_projeto_instalacao_geral", default: false, null: false
    #t.boolean "insp_contratada_vaso_projeto_instalacao_dovaso_individual", default: false, null: false
    #t.boolean "insp_contratada_valvsegpop_interna", default: false, null: false
    #t.boolean "insp_contratada_valvsegpop_externa", default: true, null: false
    #t.boolean "insp_pressostato", default: true, null: false
    #t.boolean "insp_manometro", default: true, null: false
    #t.boolean "insp_dreno", default: true, null: false
    #t.integer "mte_norma_id", default: 1, null: false
    #t.string "codigo_usado_inspecao", limit: 35, default: "-x-x-x-x-x-x-x-x-x-x-x-x-x-x-"
    #t.string "norma_brasileira_construcao", limit: 35, default: "-x-x-x-x-x-x-x-x-x-x-x-x-x-x-"
    #t.string "norma_brasileira_inspecao", limit: 35, default: "ABNT NBR 15417:2007"
    #t.boolean "bexiste_prontuario", default: false, null: false
    #t.boolean "bprontuario_digital", default: false, null: false
    #t.integer "foi_executada_inspecao_inicial", default: 1, null: false
    #t.boolean "bpossui_registro_seguranca", default: true, null: false
    #t.boolean "btem_data_instalacao_no_reg_seguranca", default: false, null: false
    #t.boolean "bexiste_desenho_plaqueta_identif_vaso", default: true
    #t.boolean "bexiste_desenho_conjunto_geral", default: false, null: false
    #t.boolean "bexiste_desenho_detalhes_de_todos_elementos", default: false, null: false
    #t.boolean "bexiste_memorial_calculo_teste_hidrostatico", default: false, null: false
    #t.boolean "bexiste_inspecao_periodica_interna_externa_teste_hidrostatico", default: true, null: false
    #t.boolean "bexiste_inspecao_problema_operacional", default: false, null: false
    #t.boolean "bexiste_inspecao_alteracao_operacional", default: false, null: false
    #t.boolean "bexiste_inspecao_de_alteracao", default: false, null: false
    #t.boolean "bexiste_inspecao_de_reparo", default: false, null: false
    #t.boolean "bexiste_inspecao_reconstituicao_prontuario", default: false, null: false
    #t.boolean "bexiste_inspecao_deretorno_ouparada_deoperacao", default: false, null: false
    #t.boolean "bexiste_projeto_instalacao_individual_dovaso", default: false, null: false
    #t.boolean "bexiste_projeto_instalacao_geral_localizacao_vasos", default: false, null: false
    #t.integer "tem_operador_qualificado_operacao", default: 2, null: false
    #t.boolean "bpossui_laudo_teste_hidrostatico", default: true, null: false
    #t.integer "possui_certif_calibracao_dispositivos_seguranca", default: 2, null: false
    #t.integer "possui_relatorios_inspecao", default: 1, null: false
    #t.boolean "bpossui_programacao_inspecoes", default: true, null: false
    #t.integer "recomendacoes_insp_anterior_foram_realizadas", default: 1
    #t.boolean "bpossui_mapa_medicao_espessura", default: false, null: false
    #t.boolean "bpossui_plaqueta_identificacao_fabricante_vaso", default: true, null: false
    #t.boolean "bpossui_plaqueta_identificacao_nr13_dovaso", default: true, null: false
    #t.boolean "bmanometro_ehmantido_calibrado_eemboas_condicoes_operacao", default: true, null: false
    #t.boolean "bpressostato_ehmantido_calibrado_eemboas_condicoes_operacao", default: true, null: false
    #t.boolean "boutros_elementos_controle_ehmantido_calib_eemboas_condicoes_op", default: true, null: false
    #t.string "anotacoes_elementos_controle_calibrados_eemboas_condicoes_opera", limit: 100
    #t.boolean "bvaso_emoperacao_mesmocom_deterioracao_atestada", default: false, null: false
    #t.boolean "bpossui_placa_dolocal_deinstalacao", default: false, null: false
    #t.boolean "belementos_facilmente_acessiveis_drenosrespiroseoutros", default: true, null: false
    #t.boolean "bpossui_manometro_ousimilar", default: true, null: false
    
    #t.integer "tipo_cobetura", default: 1, null: false
    #t.boolean "bdispoe_duassaidas_amplas_sinalizadas_desobstruidas", default: true, null: false
    #t.boolean "bdispor_acesso_facil_seguro_paraoperacao_manutencao", default: true, null: false
    #t.boolean "bdispor_ventilacao_permanente", default: true, null: false
    #t.boolean "bdispor_iluminacao_artificial", default: true, null: false
    #t.boolean "bpossui_iluminacao_emergencia", default: true, null: false
    #t.integer "possui_dispositivo_deseguranca", default: 1, null: false
    #t.integer "possui_dispositivo_contra_bloqueio_dodisp_seg", default: 2, null: false
    #t.boolean "bman_tem_sinais_manutencao", default: true, null: false
    #t.boolean "bman_foifeito_ajuste", default: false, null: false
    #t.boolean "bman_foifeita_calibracao", default: false, null: false
    #t.boolean "bman_foi_substituido", default: false, null: false
    #t.boolean "bdispseg_tem_sinais_manutencao", default: true, null: false
    #t.boolean "bdispseg_foifeito_ajuste", default: false, null: false
    #t.boolean "bdispseg_foifeita_calibracao", default: false, null: false
    #t.boolean "bdispseg_foisubstituido", default: false, null: false
    #t.boolean "bdreno_tem_sinais_manutencao", default: true, null: false
    #t.boolean "bdreno_foiacionado_paradrenar_liqacumulado", default: true, null: false
    #t.boolean "bdreno_foifeita_manutencao", default: false, null: false
    #t.boolean "bdreno_posicionado_ptomais_baixo", default: true, null: false
    #t.boolean "bdreno_foisubstituido", default: false, null: false
    #t.string "manometro_observacoes", limit: 100
    #t.string "dispositivoseg_observacoes", limit: 100
    #t.float "dispositivoseg_pabertura", default: 0.0, null: false
    
    #t.boolean "bdreno_inclinacao_positiva", default: true, null: false
    #t.string "dreno_observacoes", limit: 100
    #t.float "dreno_qtdadeliquido_drenado", default: 0.0, null: false
    #t.boolean "bpressostato_existe", default: true, null: false
    #t.boolean "bpressostato_tem_sinais_manutencao", default: true, null: false
    #t.boolean "bpressostato_foifeito_ajuste", default: false, null: false
    #t.boolean "bpressostato_foiverificada_faixadetrabalho", default: true, null: false
    #t.boolean "bpressostato_foisubstituido", default: false, null: false
    #t.float "pressostato_pliga", default: 0.0, null: false
    #t.float "pressostato_pdesliga", default: 0.0, null: false
    #t.string "pressostato_observacoes", limit: 100
    #t.boolean "bexiste_corrosaoacentuada_trincas_oupartes_soltas", default: false, null: false
    #t.integer "tipo_degrausacesso_eguardacorpo_boascondicoes", default: 2, null: false
    #t.integer "partesup_pisos_passarelas_platafor_eos_perfis_sustent_emboascon", default: 2, null: false
    #t.boolean "bexiste_falha_nasolda_entreberco_ecasco_dovaso", default: false, null: false
    #t.boolean "bexiste_corrosao_outrincas_noselementos_fixacao", default: false, null: false
    #t.boolean "bpintura_emboas_condicoes", default: true, null: false
    #t.string "obs_inspecao_elementos_sobre_o_vaso_ou_nao", limit: 100
    #t.boolean "bexiste_deformacoes_trincas_vazamentos_vaso", default: false, null: false
    #t.boolean "basconexoes_eacessorios_estao_emboas_condicoesfisicas", default: true, null: false
    #t.boolean "basconexoes_acessorios_apresentamvazamentos", default: false, null: false
    #t.boolean "baspartes_moveis_estao_protegidas", default: true, null: false
    #t.boolean "bdreno_existe", default: true, null: false
    
    #t.date "data_reparos_alteracoes"
    #t.text "recomendacoes_ao_usuario"
    #t.text "intervencoes_feitas_pelo_ph"
    #t.boolean "belaborado_reg_seg", default: false, null: false
    #t.boolean "belaborado_desenho_plaqueta", default: false, null: false
    #t.boolean "belaborado_laudo_th", default: false, null: false
    #t.boolean "belaborado_programacao_insp", default: false, null: false
    #t.boolean "belaborado_mapa_espessura", default: false, null: false
    #t.boolean "belaborado_plaqueta_identificacao", default: false, null: false
    #t.text "relacao_rgi", default: "NENHUM RGI ENCONTRADO"
    #t.boolean "belaborada_placa_local_inst", default: false, null: false
    #t.boolean "bajuste_inclinacao", default: false, null: false
    #t.integer "prazo_recomendacoes", default: 60, null: false
    #t.text "result_insp_externa"
    #t.text "result_insp_interna"
    #t.date "dt_prox_insp_externa", default: -> { "(CURRENT_DATE + 365)" }, null: false
    #t.date "dt_prox_insp_interna", default: -> { "(CURRENT_DATE + 3650)" }, null: false
    #t.date "dt_prox_teste_hidrostatico", default: -> { "(CURRENT_DATE + 5475)" }, null: false
    #t.date "dt_prox_insp_externa_dispositivo_seguranca", default: -> { "(CURRENT_DATE + 365)" }, null: false
    #t.date "dt_prox_insp_interna_dispositivo_seguranca", default: -> { "(CURRENT_DATE + 3650)" }, null: false
    #t.text "parecer_quanto_integridade_vaso"
    #t.string "PATCH_IMG_FOTO_ANTES_INSPECAO", limit: 100, default: "fig/fabricante_numserie/2021mm/antes.jpg"
    #t.string "PATCH_IMG_FOTO_POS_INSPECAO", limit: 100, default: "fig/fabricante_numserie/2021mm/pos.jpg"
    #t.string "PATCH_IMG_FOTO_TH", limit: 100, default: "fig/fabricante_numserie/2021mm/th.jpg"
    #t.string "PATCH_IMG_FOTO_INSTALACAO", limit: 100, default: "fig/fabricante_numserie/2021mm/inst.jpg"
    #t.string "PATCH_MG_FOTO_CORPO_VASO", limit: 100, default: "fig/fabricante_numserie/2021mm/corpo.jpg"
    #t.string "PATCH_IMG_FOTO_INTERNA1", limit: 100, default: "fig/fabricante_numserie/2021mm/int1.jpg"
    #t.string "PATCH_IMG_FOTO_INTERNA2", limit: 100, default: "fig/fabricante_numserie/2021mm/int2.jpg"
    #t.string "PATCH_IMG_FOTO_INTERNA3", limit: 100, default: "fig/fabricante_numserie/2021mm/int3.jpg"
    #t.string "PATCH_IMG_FOTO_INTERNA4", limit: 100, default: "fig/fabricante_numserie/2021mm/int4.jpg"
    
    #t.boolean "brel_impresso", default: false, null: false
    #t.boolean "belaborado_prontuario", default: false, null: false
    #t.boolean "brevisado", default: false, null: false
    #t.boolean "benviada_placa_local_para_confeccao", default: false
    
    #t.binary "foto_antes_inspecao"
    #t.binary "foto_pos_inspecao"
    #t.binary "foto_th"
    #t.binary "foto_instalacao"
    #t.binary "foto_corpo"
    #t.binary "foto_interna1"
    #t.binary "foto_interna2"
    #t.binary "foto_interna3"
    #t.binary "foto_interna4"
    #t.boolean "b_laudoth_eh_2avia", default: false, null: false
    #t.string "nova_venda_obs", limit: 120
    #t.boolean "nova_venda_aguarda_resposta", default: false, null: false
    #t.boolean "nova_venda_fora_lista", default: false, null: false
    #t.boolean "b_vaso_inativo_mais_doze_meses", default: false
    #t.integer "possui_acesso_visual_externo", default: 1
    #t.integer "fluido_servico_id", default: 0
    
                                  )
    end
    
    def get_relacoes
      #@fabricantes        = Cadastro.where(eh_fabricante: true).order(:nome_curto)      
      #@proprietarias      = Cadastro.order(:nome_curto)
      #@catnr13s           = Catnr13.order(:id)
      #@tipo_compressors   = TipoCompressor.order(:tipo_compressor)
      #@tipo_drenos        = TipoDreno.order(:tipo_dreno)
      #@relatorio_inis     = Relatorio.order(:id)
      #@tipo_vasos         = TipoVaso.order(:tipo_vaso)
      #@codigo_construcaos = CodigoConstrucao.order(:codigo)
      #@fluido_servicos    = FluidoServico.order(:descricao)
      #@potencial_riscos   = PotencialRisco.order(:descricao)
      #@classe_fluidos     = ClasseFluido.order(:descricao)
      #@tipo_dispositivo_segurancas = TipoDispositivoSeguranca.order(:descricao)
      #@materials          = Material.order(:descricao)
      @users              = User.order(:nome).order(:sobrenome)
      @tipo_inspecaos     = TipoInspecao.order(:nome)
      @arts               = Art.includes(:cadastro).order(id: :desc).limit(20)
      @phs                = Ph.order(:nome)
      @cidades            = Cidade.order(:nome)
      @vasos              = Vaso.includes(:fabricante).order(:num_serie)
      @finalidade_vasos   = FinalidadeVaso.all
      @proprietarias      = Cadastro.order(:nome_curto)
      @inspetoras         = Cadastro.where(eh_empresa_inspetora: true).order(:nome_curto)
    end
  
end
