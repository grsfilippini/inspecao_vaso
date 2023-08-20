class AdminsBackoffice::RelatoriosController < AdminsBackofficeController
  before_action :set_relatorio, only: [:edit, :update, :destroy,
                                       :inspecao_doc_existente,
                                       :inspecao_verif_iniciais,
                                       :inspecao_insp_contratadas,
                                       :inspecao_insp_normas,
                                       :inspecao_insp_instalacoes,
                                       :inspecao_insp_manometro,
                                       :inspecao_insp_dispseg,
                                       :inspecao_insp_pressostato,
                                       :inspecao_insp_dreno,
                                       :inspecao_insp_vaso_outros,
                                       :inspecao_fotos,
                                       :form_edita_um_relatorio,
                                       :avaliarph]
  before_action :get_relacoes, only: [:new, :edit]
  
  def index
    @relatorios = Relatorio.relatorios_concluidos(params[:page])
    @nome_rel = 'Concluídos'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
    @em_aberto = FALSE
  end
  
  def para_imprimir
    @relatorios = Relatorio.relatorios_para_imprimir(params[:page])
    @nome_rel = 'para Impressão'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
    @em_aberto = FALSE
  end
  
  def em_aberto
    @relatorios = Relatorio.relatorios_em_aberto(params[:page])
    @nome_rel = 'em Aberto (rascunho)'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
    @em_aberto = TRUE
  end

  def pesquisa    
    @relatorios = Relatorio.pesquisa_serie_prop(params[:page], params[:num_serie], params[:proprietaria_id])
    @nome_rel = 'Concluídos (pesquisa)'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
    @em_aberto = FALSE
  end
  
  def new
    @relatorio = Relatorio.new     
  end

  def edit # Ação de edição        
  end

  def form_busca_um_relatorio
    #@relatorio = Relatorio.new
  end

  def form_edita_um_relatorio
    redirect_to edit_admins_backoffice_relatorio_path(@relatorio.id)
  end

  def create      
    @relatorio = Relatorio.new(params_relatorio)    
    if @relatorio.save   
      if params[:btn_criar]
        redirect_to admins_backoffice_relatorio_em_aberto_path, notice: "Relatório criado com sucesso!"
      else
        redirect_to admins_backoffice_inspecao_doc_existente_path(id: @relatorio.id), notice: "Relatório criado com sucesso! Iniciando a inspeção."
      end
    else
      get_relacoes
      render :new
    end
  end

  def destroy
    if @relatorio.destroy
      redirect_to admins_backoffice_relatorio_em_aberto_path, notice: "Relatório excluído com sucesso!"
    else
      render :index
    end
  end


  def inspecao_doc_existente
    @etapa = 'Documentação Existente'
  end
  
  def inspecao_verif_iniciais
    @fluido_servicos = FluidoServico.order(:descricao)
    @etapa = 'Verificações Iniciais'
  end

  def inspecao_insp_contratadas
    @etapa = 'Inspeções Contratadas'
  end
    
  def inspecao_insp_normas
    @mte_normas = MteNorma.all
    @etapa = 'Normas Utilizadas na Inspeção'
  end
  
  def inspecao_insp_instalacoes
    @ambiente_insts = AmbienteInst.all
    @etapa = 'Instalações'
  end
  
  def inspecao_insp_manometro    
    @etapa = 'Manômetro'
  end
  
  def inspecao_insp_dispseg
    @etapa = 'Dispositivo de Segurança'
  end
  
  def inspecao_insp_pressostato
    @etapa = 'Pressostato'
  end
  
  def inspecao_insp_dreno
    @tipo_drenos = TipoDreno.order(:tipo_dreno)
    @etapa = 'Dreno'
  end
  
  def inspecao_insp_vaso_outros
    @etapa = 'Vaso e outros'
  end

  def inspecao_fotos
    @etapa = 'Fotos'
  end
  
  def avaliarph
    get_relacoes
    @ultimo_rel = Relatorio.where(vaso_id: @relatorio.vaso_id).order(id: :desc).first
  end

  def update              
    if params_relatorio.present?      
      if @relatorio.update(params_relatorio)                
        # Verificar se um novo arquivo de imagem foi enviado
        if params[:relatorio][:foto_antes_inspecao].present?
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @relatorio.update_attribute(:foto_antes_inspecao, params[:relatorio][:foto_antes_inspecao].read)
        end
        if params[:relatorio][:foto_pos_inspecao].present?
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @relatorio.update_attribute(:foto_pos_inspecao, params[:relatorio][:foto_pos_inspecao].read)
        end
        if params[:relatorio][:foto_corpo].present?
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @relatorio.update_attribute(:foto_corpo, params[:relatorio][:foto_corpo].read)
        end
        if params[:relatorio][:foto_instalacao].present?
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @relatorio.update_attribute(:foto_instalacao, params[:relatorio][:foto_instalacao].read)
        end
        if params[:relatorio][:foto_th].present?
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @relatorio.update_attribute(:foto_th, params[:relatorio][:foto_th].read)
        end
        if params[:relatorio][:foto_interna1].present?
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @relatorio.update_attribute(:foto_interna1, params[:relatorio][:foto_interna1].read)
        end
        if params[:relatorio][:foto_interna2].present?
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @relatorio.update_attribute(:foto_interna2, params[:relatorio][:foto_interna2].read)
        end
        if params[:relatorio][:foto_interna3].present?
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @relatorio.update_attribute(:foto_interna3, params[:relatorio][:foto_interna3].read)
        end
        if params[:relatorio][:foto_interna4].present?
          # Atualizar o campo de imagem diretamente com o novo arquivo
          @relatorio.update_attribute(:foto_interna4, params[:relatorio][:foto_interna4].read)
        end      
        
        redireciona_para_guia
        
      else
        get_relacoes
        render 'edit'
      end

    else
      redireciona_para_guia
    end    
  end
  
# Redireciona para a guia conforme o button que estiver presente em params
def redireciona_para_guia
  # Direciona para próxima tela ou tela anterior conforme botão pressionado
  if params[:btn_gravar_sair] || params[:btn_gravar_avaliacaoph]
    redirect_to admins_backoffice_relatorio_em_aberto_path, notice: "Relatório atualizado com sucesso!"
  # Início da inspeção
  elsif params[:btn_insp_inicio]
    redirect_to edit_admins_backoffice_relatorio_path(@relatorio.id), notice: "Relatório atualizado com sucesso!"        
  # Documentação existente
  elsif params[:btn_doc_existente]          
    redirect_to admins_backoffice_inspecao_doc_existente_path(id: @relatorio.id), notice: "Relatório atualizado com sucesso! Indo para documentação existente."
  # Verificações iniciais  
  elsif params[:btn_verif_iniciais]          
    redirect_to admins_backoffice_inspecao_verif_iniciais_path(id: @relatorio.id), notice: "Relatório atualizado com sucesso! Indo para verificações iniciais."
  # Inspeções contratadas
  elsif params[:btn_insp_contratadas]          
    redirect_to admins_backoffice_inspecao_insp_contratadas_path(id: @relatorio.id), notice: "Relatório atualizado com sucesso! Indo para inspeções contratadas."
  # Normas utilizadas na inspeção
  elsif params[:btn_insp_normas]          
    redirect_to admins_backoffice_inspecao_insp_normas_path(id: @relatorio.id), notice: "Relatório atualizado com sucesso! Indo para normas utilizadas na inspeção."
  # Inspeções instalações
  elsif params[:btn_insp_instalacoes]          
    redirect_to admins_backoffice_inspecao_insp_instalacoes_path(id: @relatorio.id), notice: "Relatório atualizado com sucesso! Indo para inspeções das instalações."
  # Manômetro
  elsif params[:btn_insp_manometro]          
    redirect_to admins_backoffice_inspecao_insp_manometro_path(id: @relatorio.id), notice: "Relatório atualizado com sucesso! Indo para inspeção do manômetro."
  # Dispositivo de segurança
  elsif params[:btn_insp_dispseg]          
    redirect_to admins_backoffice_inspecao_insp_dispseg_path(id: @relatorio.id), notice: "Relatório atualizado com sucesso! Indo para inspeções do dispositivo de segurança."
  # Pressostato
  elsif params[:btn_insp_pressostato]          
    redirect_to admins_backoffice_inspecao_insp_pressostato_path(id: @relatorio.id), notice: "Relatório atualizado com sucesso! Indo para inspeção do pressostato."
  # Dreno
  elsif params[:btn_insp_dreno]          
    redirect_to admins_backoffice_inspecao_insp_dreno_path(id: @relatorio.id), notice: "Relatório atualizado com sucesso! Indo para inspeção do dreno."
  # Vaso e outros
  elsif params[:btn_insp_vaso_outros]          
    redirect_to admins_backoffice_inspecao_insp_vaso_outros_path(id: @relatorio.id), notice: "Relatório atualizado com sucesso! Indo para inspeção do vaso e outros."
  # Fotos
  elsif params[:btn_fotos]          
    redirect_to admins_backoffice_inspecao_fotos_path(id: @relatorio.id), notice: "Relatório atualizado com sucesso! Indo para fotos."
  end
end

  def preenche_intervencoes
    # Realize as operações necessárias para obter os dados    
    @relatorio = Relatorio.find(params[:relatorio_id])

    respond_to do |format|
      format.js # Isso renderizará um arquivo JavaScript correspondente ao seu_metodo.js.erb
    end
  end

  def preenche_recomendacoes
    # Realize as operações necessárias para obter os dados    
    @relatorio = Relatorio.find(params[:relatorio_id])

    respond_to do |format|
      format.js # Isso renderizará um arquivo JavaScript correspondente ao seu_metodo.js.erb
    end
  end

  def preenche_rgi
    # Realize as operações necessárias para obter os dados    
    @relatorio = Relatorio.find(params[:relatorio_id])

    respond_to do |format|
      format.js # Isso renderizará um arquivo JavaScript correspondente ao seu_metodo.js.erb
    end
  end

  def preenche_insp_externa
    # Realize as operações necessárias para obter os dados    
    @relatorio = Relatorio.find(params[:relatorio_id])

    respond_to do |format|
      format.js # Isso renderizará um arquivo JavaScript correspondente ao seu_metodo.js.erb
    end
  end

  def preenche_insp_interna
    # Realize as operações necessárias para obter os dados    
    @relatorio = Relatorio.find(params[:relatorio_id])

    respond_to do |format|
      format.js # Isso renderizará um arquivo JavaScript correspondente ao seu_metodo.js.erb
    end
  end

  def preenche_parecer_conclusivo
    # Realize as operações necessárias para obter os dados    
    @relatorio = Relatorio.find(params[:relatorio_id])

    respond_to do |format|
      format.js # Isso renderizará um arquivo JavaScript correspondente ao seu_metodo.js.erb
    end
  end

  private
    def set_relatorio
      @relatorio = Relatorio.find(params[:id])      
    end
   
    def params_relatorio
      if params.key?(:relatorio)  
        params.require(:relatorio).permit(:user_id,
                                          :b_rascunho,
                                          :avaliadoph,
                                          :brel_impresso,
                                          :tipo_inspecao_id,
                                          :art_id,
                                          :ph_id,
                                          :cidade_id,
                                          :data_relatorio,
                                          :vaso_id,
                                          :finalidade_vaso_id,
                                          :proprietaria_id,                                   
                                          :inspetora_id,
                                          
                                          # Docs existentes
                                          :bexiste_prontuario,
                                          :bprontuario_digital,
                                          :foi_executada_inspecao_inicial,
                                          :bpossui_registro_seguranca,
                                          :btem_data_instalacao_no_reg_seguranca,
                                          :bpossui_laudo_teste_hidrostatico,
                                          :bpossui_mapa_medicao_espessura,
                                          :bpossui_programacao_inspecoes,
                                          :bexiste_inspecao_periodica_interna_externa_teste_hidrostatico,
                                          :bexiste_inspecao_reconstituicao_prontuario,
                                          :bpossui_plaqueta_identificacao_fabricante_vaso,
                                          :bpossui_plaqueta_identificacao_nr13_dovaso,
                                          :bexiste_desenho_plaqueta_identif_vaso,
                                          :possui_relatorios_inspecao,
                                          :possui_certif_calibracao_dispositivos_seguranca,
                                          # pouco usados
                                          :bexiste_memorial_calculo_teste_hidrostatico,
                                          :bexiste_inspecao_problema_operacional,
                                          :bexiste_inspecao_alteracao_operacional,
                                          :bexiste_inspecao_de_alteracao,
                                          :bexiste_inspecao_de_reparo,
                                          :bexiste_inspecao_deretorno_ouparada_deoperacao,
                                          :tem_operador_qualificado_operacao,
                                          :bexiste_desenho_conjunto_geral,
                                          :bexiste_desenho_detalhes_de_todos_elementos,
                                          :bexiste_projeto_instalacao_geral_localizacao_vasos,
                                          :bexiste_projeto_instalacao_individual_dovaso,
                                          
                                          # Verificações iniciais
                                          :recomendacoes_insp_anterior_foram_realizadas,
                                          :bvaso_emoperacao_mesmocom_deterioracao_atestada,
                                          :fluido_servico_id,
                                          :tipo_apresenta_sinais_reparo,
                                          :data_reparos_alteracoes,
                                          :reparos_observados,
                                          :tipo_fixacao_vaso,
                                          :tipo_houve_alteracao_local_instalacao,
                                          :b_vaso_inativo_mais_doze_meses,
                                          :tipo_acesso_interno,
                                          :metodo_alternativo_exame_interno,
                                          :possui_acesso_visual_externo,
                                          :possui_respiro,
                                          :possui_indicador_nivel,
                                          :possui_indicador_temperatura,
                                              
                                          # Inspeções contratadas
                                          :insp_contratada_vaso_inicial,
                                          :insp_contratada_vaso_reconstituicao_prontuario,
                                          :insp_contratada_vaso_externa,
                                          :insp_contratada_vaso_interna,
                                          :insp_contratada_vaso_teste_hidrostatico,
                                          :insp_contratada_vaso_mapa_espessura,
                                          :insp_contratada_valvsegpop_externa,
                                          :insp_contratada_valvsegpop_interna,
                                          :insp_pressostato,
                                          :insp_manometro,
                                          :insp_dreno,
                                          :insp_contratada_vaso_paradaretorno_operacao,
                                          :insp_contratada_vaso_problema_operacional,
                                          :insp_contratada_vaso_alteracao_operacional,
                                          :insp_contratada_vaso_alteracao_estrutural,
                                          :insp_contratada_vaso_alteracao_reparo,
                                          :insp_contratada_vaso_projeto_instalacao_geral,
                                          :insp_contratada_vaso_projeto_instalacao_dovaso_individual,
                                          
                                          # Normas utilizadas na inspeção
                                          :mte_norma_id,
                                          :norma_brasileira_inspecao,
                                          :codigo_usado_inspecao,
                                          :norma_brasileira_construcao,
                                          
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
                                          :bman_tem_sinais_manutencao,
                                          :bman_foifeito_ajuste,
                                          :bman_foifeita_calibracao,
                                          :manometro_observacoes,
                                          
                                          # Inspeção do dispositivo de segurança
                                          :possui_dispositivo_deseguranca,
                                          :bBloqueioInadvertidoIntencionalDoDispSeg,
                                          :possui_dispositivo_contra_bloqueio_dodisp_seg,
                                          :bdispseg_tem_sinais_manutencao,
                                          :bdispseg_foisubstituido,
                                          :bdispseg_foifeito_ajuste,
                                          :bdispseg_foifeita_calibracao,
                                          :dispositivoseg_observacoes,
                                          :dispositivoseg_pabertura,
                                          
                                          # Inspeção do pressostato
                                          :bpressostato_existe,
                                          :bpressostato_ehmantido_calibrado_eemboas_condicoes_operacao,
                                          :bpressostato_tem_sinais_manutencao,
                                          :bpressostato_foisubstituido,
                                          :bpressostato_foifeito_ajuste,
                                          :bpressostato_foiverificada_faixadetrabalho,
                                          :pressostato_pliga,
                                          :pressostato_pdesliga,
                                          :pressostato_observacoes,
                                          
                                          # Existe dreno
                                          :bdreno_existe,
                                          :bdreno_tem_sinais_manutencao,
                                          :tipo_dreno_id,
                                          :bdreno_posicionado_ptomais_baixo,
                                          :bdreno_inclinacao_positiva,
                                          :bajuste_inclinacao,
                                          :bdreno_foisubstituido,
                                          :bdreno_foifeita_manutencao,
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
                                          # acesso
                                          :tipo_degrausacesso_eguardacorpo_boascondicoes,
                                          :partesup_pisos_passarelas_platafor_eos_perfis_sustent_emboascon,
                                          :obs_inspecao_elementos_sobre_o_vaso_ou_nao,
                                          
                                          :boutros_elementos_controle_ehmantido_calib_eemboas_condicoes_op,
                                          :anotacoes_elementos_controle_calibrados_eemboas_condicoes_opera,
                                          
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

                                          # intervenções
                                          :belaborado_reg_seg,
                                          :belaborado_prontuario,
                                          :belaborado_laudo_th,
                                          :b_laudoth_eh_2avia,
                                          :belaborado_programacao_insp,
                                          :belaborado_desenho_plaqueta,
                                          :belaborado_mapa_espessura,
                                          :belaborada_placa_local_inst,
                                          :belaborado_plaqueta_identificacao,
                                          :intervencoes_feitas_pelo_ph,

                                          # recomendações
                                          :recomendacoes_ao_usuario,
                                          :prazo_recomendacoes,

                                          # rgi
                                          :relacao_rgi,

                                          # resultado da inspeção externa
                                          :result_insp_externa,

                                          # resultado da inspeção interna
                                          :result_insp_interna,

                                          # parecer conclusivo sobre a integridade estrutural do vaso
                                          :parecer_quanto_integridade_vaso,

                                          # programação das inspeções
                                          :dt_prox_insp_externa,
                                          :dt_prox_insp_interna,
                                          :dt_prox_teste_hidrostatico,
                                          :dt_prox_insp_externa_dispositivo_seguranca,
                                          :dt_prox_insp_interna_dispositivo_seguranca
      
      #t.boolean "brevisado", default: false, null: false
      #t.boolean "benviada_placa_local_para_confeccao", default: false
  
      #t.string "nova_venda_obs", limit: 120
      #t.boolean "nova_venda_aguarda_resposta", default: false, null: false
      #t.boolean "nova_venda_fora_lista", default: false, null: false      
                                    )
      else        
      end
    end
    
    #t.integer "ph_id", default: 0, null: false
    #t.date "data_relatorio", default: -> { "CURRENT_DATE" }, null: false
    #t.integer "vaso_id", null: false
    #t.integer "proprietaria_id", null: false
    #t.integer "inspetora_id", default: 52, null: false
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
    #t.boolean "bexiste_prontuario", default: true, null: false
    #t.boolean "bprontuario_digital", default: false, null: false
    #t.integer "foi_executada_inspecao_inicial", default: 0, null: false
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
    #t.integer "finalidade_vaso_id", default: 0, null: false
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
    #t.integer "tipo_inspecao_id", default: 0, null: false
    #t.boolean "brel_impresso", default: false, null: false
    #t.boolean "belaborado_prontuario", default: false, null: false
    #t.boolean "brevisado", default: false, null: false
    #t.boolean "benviada_placa_local_para_confeccao", default: false
    #t.boolean "b_rascunho", default: true, null: false, comment: "Quando TRUE indica que trata-se de um rascunho de relatório, ou seja, é um relatório em andamento, ainda não finalizado."
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
    #t.bigint "user_id"
    #t.bigint "art_id"
    #t.bigint "cidade_id"
    #t.integer "ambiente_inst_id", default: 2
    #t.integer "tipo_dreno_id", default: 0    
    
    
    
    
    
    
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
