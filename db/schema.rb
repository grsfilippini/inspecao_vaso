# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_02_15_125948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "MEDIDA_ESPESSURA_VASO", primary_key: "ID", id: :serial, force: :cascade do |t|
    t.integer "VASO", null: false
    t.float "esp_casco_1"
    t.float "esp_casco_2"
    t.float "esp_casco_3"
    t.float "esp_casco_4"
    t.float "esp_casco_5"
    t.float "esp_casco_6"
    t.float "esp_casco_7"
    t.float "esp_casco_8"
    t.float "esp_casco_9"
    t.float "esp_casco_10"
    t.date "DATA", default: -> { "CURRENT_DATE" }
    t.integer "instrumentopadrao_id", default: 3, null: false
    t.integer "empresainspetora_id", default: 52, null: false
    t.float "esp_min_corpo"
    t.float "esp_min_tampo"
  end

  create_table "RELATORIO_INSPECAO", primary_key: "ID", id: :serial, force: :cascade do |t|
    t.bigint "art", default: 0, null: false
    t.integer "idph", default: 0, null: false
    t.string "cidade_relatorio", limit: 50, null: false
    t.date "data_relatorio", default: -> { "CURRENT_DATE" }, null: false
    t.integer "id_vaso_pressao", null: false
    t.integer "id_empresa_vaso_instalado", null: false
    t.integer "id_empresa_inspetora", default: 52, null: false
    t.integer "tipo_acesso_interno", default: 1, null: false
    t.text "metodo_alternativo_exame_interno"
    t.string "tipo_acesso_externo", limit: 100, default: "true", null: false
    t.integer "tipo_apresenta_sinais_reparo", default: 0, null: false
    t.text "reparos_observados"
    t.integer "tipo_fixacao_vaso", default: 0, null: false
    t.integer "tipo_houve_alteracao_local_instalacao", default: 0, null: false
    t.integer "b_vaso_inativo_mais_doze_meses", default: 0, null: false
    t.boolean "possui_dreno", default: true, null: false
    t.boolean "possui_boca_visita"
    t.boolean "possui_respiro", default: false, null: false
    t.boolean "possui_indicador_nivel", default: false, null: false
    t.boolean "possui_indicador_temperatura", default: false, null: false
    t.boolean "insp_contratada_vaso_externa", default: true, null: false
    t.boolean "insp_contratada_vaso_interna", default: false, null: false
    t.boolean "insp_contratada_vaso_teste_hidrostatico", default: false, null: false
    t.boolean "insp_contratada_vaso_mapa_espessura", default: false, null: false
    t.boolean "insp_contratada_vaso_inicial", default: false, null: false
    t.boolean "insp_contratada_vaso_problema_operacional", default: false, null: false
    t.boolean "insp_contratada_vaso_alteracao_operacional", default: false, null: false
    t.boolean "insp_contratada_vaso_alteracao_estrutural"
    t.boolean "insp_contratada_vaso_alteracao_reparo", default: false, null: false
    t.boolean "insp_contratada_vaso_reconstituicao_prontuario", default: false, null: false
    t.boolean "insp_contratada_vaso_paradaretorno_operacao", default: false, null: false
    t.boolean "insp_contratada_vaso_projeto_instalacao_geral", default: false, null: false
    t.boolean "insp_contratada_vaso_projeto_instalacao_dovaso_individual", default: false, null: false
    t.boolean "insp_contratada_valvsegpop_interna", default: false, null: false
    t.boolean "insp_contratada_valvsegpop_externa", default: true, null: false
    t.boolean "insp_contratada_valvsegealivio_interna", default: false, null: false
    t.boolean "insp_contratada_valvsegealivio_externa", default: false, null: false
    t.boolean "insp_contratada_valvalivio_interna", default: false, null: false
    t.boolean "insp_contratada_valvalivio_externa", default: false, null: false
    t.boolean "insp_pressostato", default: true, null: false
    t.boolean "insp_manometro", default: true, null: false
    t.boolean "insp_dreno", default: true, null: false
    t.integer "fk_norma_mte", default: 1, null: false
    t.string "codigo_usado_inspecao", limit: 35, default: "-x-x-x-x-x-x-x-x-x-x-x-x-x-x-"
    t.string "norma_brasileira_construcao", limit: 35, default: "-x-x-x-x-x-x-x-x-x-x-x-x-x-x-"
    t.string "norma_brasileira_inspecao", limit: 35, default: "ABNT NBR 15417:2007"
    t.boolean "bexiste_prontuario", default: false, null: false
    t.boolean "bprontuario_digital", default: false, null: false
    t.integer "foi_executada_inspecao_inicial", default: 1, null: false
    t.boolean "bpossui_registro_seguranca", default: true, null: false
    t.boolean "btem_data_instalacao_no_reg_seguranca", default: false, null: false
    t.boolean "bexiste_desenho_plaqueta_identif_vaso", default: true
    t.boolean "bexiste_desenho_conjunto_geral", default: false, null: false
    t.boolean "bexiste_desenho_detalhes_de_todos_elementos", default: false, null: false
    t.boolean "bexiste_memorial_calculo_teste_hidrostatico", default: false, null: false
    t.boolean "bexiste_inspecao_periodica_interna_externa_teste_hidrostatico", default: true, null: false
    t.boolean "bexiste_inspecao_inicio_operacao", default: false, null: false
    t.boolean "bexiste_inspecao_problema_operacional", default: false, null: false
    t.boolean "bexiste_inspecao_alteracao_operacional", default: false, null: false
    t.boolean "bexiste_inspecao_de_alteracao", default: false, null: false
    t.boolean "bexiste_inspecao_de_reparo", default: false, null: false
    t.boolean "bexiste_inspecao_reconstituicao_prontuario", default: false, null: false
    t.boolean "bexiste_inspecao_deretorno_ouparada_deoperacao", default: false, null: false
    t.boolean "bexiste_projeto_instalacao_individual_dovaso", default: false, null: false
    t.boolean "bexiste_projeto_instalacao_geral_localizacao_vasos", default: false, null: false
    t.integer "tem_operador_qualificado_operacao", default: 2, null: false
    t.boolean "bpossui_laudo_teste_hidrostatico", default: true, null: false
    t.integer "possui_certif_calibracao_dispositivos_seguranca", default: 2, null: false
    t.integer "possui_relatorios_inspecao", default: 1, null: false
    t.boolean "bpossui_programacao_inspecoes", default: true, null: false
    t.integer "recomendacoes_insp_anterior_foram_realizadas", default: 1
    t.boolean "bpossui_mapa_medicao_espessura", default: false, null: false
    t.boolean "bpossui_plaqueta_identificacao_fabricante_vaso", default: true, null: false
    t.boolean "bpossui_plaqueta_identificacao_nr13_dovaso", default: true, null: false
    t.boolean "bmanometro_ehmantido_calibrado_eemboas_condicoes_operacao", default: true, null: false
    t.boolean "bpressostato_ehmantido_calibrado_eemboas_condicoes_operacao", default: true, null: false
    t.boolean "boutros_elementos_controle_ehmantido_calib_eemboas_condicoes_op", default: true, null: false
    t.string "anotacoes_elementos_controle_calibrados_eemboas_condicoes_opera", limit: 100
    t.boolean "bvaso_emoperacao_mesmocom_deterioracao_atestada", default: false, null: false
    t.boolean "bpossui_placa_dolocal_deinstalacao", default: false, null: false
    t.boolean "belementos_facilmente_acessiveis_drenosrespiroseoutros", default: true, null: false
    t.boolean "bpossui_manometro_ousimilar", default: true, null: false
    t.integer "tipo_ambiente_instalacao_vaso_pressao", default: 2, null: false
    t.integer "tipo_cobetura", default: 1, null: false
    t.boolean "bdispoe_duassaidas_amplas_sinalizadas_desobstruidas", default: true, null: false
    t.boolean "bdispor_acesso_facil_seguro_paraoperacao_manutencao", default: true, null: false
    t.boolean "bdispor_ventilacao_permanente", default: true, null: false
    t.boolean "bdispor_iluminacao_artificial", default: true, null: false
    t.boolean "bpossui_iluminacao_emergencia", default: true, null: false
    t.integer "possui_dispositivo_deseguranca", default: 1, null: false
    t.integer "possui_dispositivo_contra_bloqueio_dodisp_seg", default: 2, null: false
    t.boolean "bman_tem_sinais_manutencao", default: true, null: false
    t.boolean "bman_foifeito_ajuste", default: false, null: false
    t.boolean "bman_foifeita_calibracao", default: false, null: false
    t.boolean "bman_foi_substituido", default: false, null: false
    t.boolean "bdispseg_tem_sinais_manutencao", default: true, null: false
    t.boolean "bdispseg_foifeito_ajuste", default: false, null: false
    t.boolean "bdispseg_foifeita_calibracao", default: false, null: false
    t.boolean "bdispseg_foisubstituido", default: false, null: false
    t.boolean "bdreno_tem_sinais_manutencao", default: true, null: false
    t.boolean "bdreno_foiacionado_paradrenar_liqacumulado", default: true, null: false
    t.boolean "bdreno_foifeita_manutencao", default: false, null: false
    t.boolean "bdreno_posicionado_ptomais_baixo", default: true, null: false
    t.boolean "bdreno_foisubstituido", default: false, null: false
    t.string "manometro_observacoes", limit: 100
    t.string "dispositivoseg_observacoes", limit: 100
    t.float "dispositivoseg_pabertura", default: 0.0, null: false
    t.integer "tipo_acionamentodreno", default: 0, null: false
    t.boolean "bdreno_inclinacao_positiva", default: true, null: false
    t.string "dreno_observacoes", limit: 100
    t.float "dreno_qtdadeliquido_drenado", default: 0.0, null: false
    t.boolean "bpressostato_existe", default: true, null: false
    t.boolean "bpressostato_tem_sinais_manutencao", default: true, null: false
    t.boolean "bpressostato_foifeito_ajuste", default: false, null: false
    t.boolean "bpressostato_foiverificada_faixadetrabalho", default: true, null: false
    t.boolean "bpressostato_foisubstituido", default: false, null: false
    t.float "pressostato_pliga", default: 0.0, null: false
    t.float "pressostato_pdesliga", default: 0.0, null: false
    t.string "pressostato_observacoes", limit: 100
    t.boolean "bexiste_corrosaoacentuada_trincas_oupartes_soltas", default: false, null: false
    t.integer "tipo_degrausacesso_eguardacorpo_boascondicoes", default: 2, null: false
    t.integer "partesup_pisos_passarelas_platafor_eos_perfis_sustent_emboascon", default: 2, null: false
    t.boolean "bexiste_falha_nasolda_entreberco_ecasco_dovaso", default: false, null: false
    t.boolean "bexiste_corrosao_outrincas_noselementos_fixacao", default: false, null: false
    t.boolean "bpintura_emboas_condicoes", default: true, null: false
    t.string "obs_inspecao_elementos_sobre_o_vaso_ou_nao", limit: 100
    t.boolean "bexiste_deformacoes_trincas_vazamentos_vaso", default: false, null: false
    t.boolean "basconexoes_eacessorios_estao_emboas_condicoesfisicas", default: true, null: false
    t.boolean "basconexoes_acessorios_apresentamvazamentos", default: false, null: false
    t.boolean "baspartes_moveis_estao_protegidas", default: true, null: false
    t.boolean "bdreno_existe", default: true, null: false
    t.integer "finalidade_vaso", default: 0, null: false
    t.date "data_reparos_alteracoes"
    t.text "RECOMENDACOES_AOUSUARIO_DOVASO_DEPRESSAO"
    t.text "INTERVENCOES_FEITAS_PELOPH_NOVASO"
    t.boolean "BELABORADO_REGISTRO_SEGURANCA", default: false, null: false
    t.boolean "BELABORADO_DESENHO_PLAQUETA", default: false, null: false
    t.boolean "BELABORADO_PLANTA_LOCALIZACAO_VASOS", default: false, null: false
    t.boolean "BELABORADO_LAUDO_TESTE_HIDROSTATICO", default: false, null: false
    t.boolean "BELABORADO_PROGRAMACAO_INSPECOES", default: false, null: false
    t.boolean "BELABORADO_MAPA_MEDICAO_ESPESSURA", default: false, null: false
    t.boolean "BELABORADO_PLAQUETA_IDENTIFICACAO_NR13_DOVASO", default: false, null: false
    t.text "RELACAO_DERGI_ENCONTRADO", default: "NENHUM RGI ENCONTRADO"
    t.boolean "BINSTALADO_MANOMETRO", default: false, null: false
    t.boolean "BELABORADA_PLACA_DOLOCAL_INSTALACAO", default: false, null: false
    t.boolean "BALTERADA_INCLINACAO_VASO", default: false, null: false
    t.integer "DIAS_PRAZO_RECOMENDACOES", default: 60, null: false
    t.text "RESULTADO_INSP_EXTERNA"
    t.text "RESULTADO_INSP_INTERNA"
    t.date "dt_prox_insp_externa", default: -> { "(CURRENT_DATE + 365)" }, null: false
    t.date "dt_prox_insp_interna", default: -> { "(CURRENT_DATE + 3650)" }, null: false
    t.date "dt_prox_teste_hidrostatico", default: -> { "(CURRENT_DATE + 5475)" }, null: false
    t.date "dt_prox_insp_externa_dispositivo_seguranca", default: -> { "(CURRENT_DATE + 365)" }, null: false
    t.date "dt_prox_insp_interna_dispositivo_seguranca", default: -> { "(CURRENT_DATE + 3650)" }, null: false
    t.text "PARECER_QUANTO_INTEGRIDADE_VASO"
    t.string "PATCH_IMG_FOTO_ANTES_INSPECAO", limit: 100, default: "fig/fabricante_numserie/2021mm/antes.jpg"
    t.string "PATCH_IMG_FOTO_POS_INSPECAO", limit: 100, default: "fig/fabricante_numserie/2021mm/pos.jpg"
    t.string "PATCH_IMG_FOTO_TH", limit: 100, default: "fig/fabricante_numserie/2021mm/th.jpg"
    t.string "PATCH_IMG_FOTO_INSTALACAO", limit: 100, default: "fig/fabricante_numserie/2021mm/inst.jpg"
    t.string "PATCH_MG_FOTO_CORPO_VASO", limit: 100, default: "fig/fabricante_numserie/2021mm/corpo.jpg"
    t.string "PATCH_IMG_FOTO_INTERNA1", limit: 100, default: "fig/fabricante_numserie/2021mm/int1.jpg"
    t.string "PATCH_IMG_FOTO_INTERNA2", limit: 100, default: "fig/fabricante_numserie/2021mm/int2.jpg"
    t.string "PATCH_IMG_FOTO_INTERNA3", limit: 100, default: "fig/fabricante_numserie/2021mm/int3.jpg"
    t.string "PATCH_IMG_FOTO_INTERNA4", limit: 100, default: "fig/fabricante_numserie/2021mm/int4.jpg"
    t.integer "TIPO_INSPECAO", default: 0, null: false
    t.boolean "BRELATORIO_IMPRESSO", default: false, null: false
    t.boolean "BELABORADO_PRONTUARIO", default: false, null: false
    t.boolean "BREVISADO", default: false, null: false
    t.boolean "BENVIOCONFECCAOPLACALOCAL", default: false
    t.boolean "inspecoes_contratadas", comment: "[1] vaso_externa,\n[2] vaso_interna,", array: true
    t.boolean "b_rascunho", default: true, null: false, comment: "Quando TRUE indica que trata-se de um rascunho de relatório, ou seja, é um relatório em andamento, ainda não finalizado."
    t.binary "foto_antes_inspecao"
    t.binary "foto_pos_inspecao"
    t.binary "foto_th"
    t.binary "foto_instalacao"
    t.binary "foto_corpo"
    t.binary "foto_interna1"
    t.binary "foto_interna2"
    t.binary "foto_interna3"
    t.binary "foto_interna4"
    t.boolean "b_laudoth_eh_2avia", default: false, null: false
    t.string "nova_venda_obs", limit: 120
    t.boolean "nova_venda_aguarda_resposta", default: false, null: false
    t.boolean "nova_venda_fora_lista", default: false, null: false
  end

  create_table "RELATORIO_INSP_VAL_SEG_E_ALIVIO", primary_key: "registro_insp_val_seg_e_alivio_id", id: :integer, default: nil, force: :cascade do |t|
    t.date "data", default: -> { "CURRENT_DATE" }, null: false
    t.integer "vaso_pressao_protegido_id", null: false
    t.float "pressao_teste_1"
    t.float "pressao_teste_2"
    t.float "pressao_teste_3"
    t.float "pressao_ajuste", null: false
    t.float "pressao_vedacao", default: 0.0
    t.boolean "bcorpo_bom_estado", default: true, null: false
    t.boolean "broscas_bom_estado", default: true, null: false
    t.boolean "bdiscovedacao_bom_estado", default: true, null: false
    t.boolean "bhaste_bom_estado", default: true, null: false
    t.boolean "bmola_bom_estado", default: true, null: false
    t.boolean "bparafusoregulagem_bom_etado", default: true, null: false
    t.boolean "balavanca_bom_estado", default: true, null: false
    t.integer "fluido_calibracao_id", default: 1, null: false
    t.integer "manometro_padrao_id", default: 2, null: false
    t.integer "cadastro_id", null: false
    t.boolean "bValvulaEhEstanque", default: true
    t.text "Observacoes"
    t.boolean "bFoiCalibrada", default: false, null: false
    t.integer "dispseguranca_id", null: false
    t.boolean "bimpresso", default: false
    t.integer "profissional_habilitado_id", default: 0, null: false
    t.integer "art_id", default: 0, null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "nome", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "ambiente_insts", force: :cascade do |t|
    t.string "ambiente"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "arts", id: :integer, default: -> { "nextval('art_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "art", limit: 15, null: false
    t.integer "cadastro_id", null: false
    t.integer "ph_id", default: 0, null: false
  end

  create_table "cadastros", id: :integer, default: -> { "nextval('cadastro_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "nome", limit: 100, null: false
    t.string "nome_curto", limit: 50, null: false
    t.string "cnpj", limit: 18, null: false
    t.string "cidade", limit: 60
    t.string "endereco", limit: 75
    t.string "cep", limit: 10
    t.string "email", limit: 40
    t.string "fone", limit: 15
    t.string "contato", limit: 35
    t.string "website", limit: 55
    t.string "observacoes", limit: 100
    t.boolean "eh_fabricante", default: false, null: false
    t.string "bairro", limit: 60
    t.boolean "eh_empresa_inspetora", default: false, null: false
    t.string "regiao", limit: 15, default: "-", null: false
    t.integer "corp_id", default: 3, null: false
    t.decimal "numero", precision: 10
  end

  create_table "catnr13s", id: :integer, default: -> { "nextval('\"CATEGORIA_NR13_ID_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "categoria", limit: 25, null: false
  end

  create_table "cidades", id: :integer, default: -> { "nextval('\"CIDADES_ID_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "nome", limit: 50, null: false
  end

  create_table "classe_fluidos", id: :integer, default: -> { "nextval('classe_fluido_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "classe", limit: 1, null: false
    t.string "descricao", limit: 250
  end

  create_table "codigo_construcaos", id: :integer, default: -> { "nextval('codigo_construcao_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "codigo", limit: 50, null: false
  end

  create_table "corps", id: :integer, default: -> { "nextval('\"CADASTRO_CORP_ID_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "nome", limit: 100, null: false
  end

  create_table "disp_segurancas", id: :integer, default: -> { "nextval('dispsegurancas_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "serie", limit: 100, null: false
    t.integer "cadastro_id", default: 67, null: false
    t.integer "tipo_dispositivo_seguranca_id", default: 2, null: false
    t.string "castelo", limit: 100
    t.string "bitola", limit: 100
    t.index ["tipo_dispositivo_seguranca_id"], name: "fki_dispsegurancas_TIPO_DISPOSITIVO_SEGURANCA_ID_fkey"
  end

  create_table "finalidade_vasos", id: :integer, default: -> { "nextval('\"FINALIDADE_DO_VASO_id_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "finalidade", limit: 100, null: false
  end

  create_table "fluido_calibracao_valv_segs", id: :integer, default: -> { "nextval('\"FLUIDOCALIBRACAOVSEG_id_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "descricao", limit: 100, null: false
  end

  create_table "fluido_servicos", id: :integer, default: -> { "nextval('\"FLUIDO_SERVICO_ID_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "descricao", limit: 40, null: false
  end

  create_table "instrumento_padraos", id: :integer, default: -> { "nextval('\"INSTRUMENTO_PADRAO_ID_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "descricao", limit: 100, null: false
    t.string "nome_curto", limit: 100, null: false
  end

  create_table "liquidos", id: :integer, default: -> { "nextval('\"LIQUIDO_ID_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "descricao", limit: 50
  end

  create_table "materials", id: :integer, default: -> { "nextval('\"MATERIAL_ID_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "descricao", limit: 90
  end

  create_table "mte_normas", id: :integer, default: nil, force: :cascade do |t|
    t.string "norma", limit: 25
    t.string "descricao", limit: 100
  end

  create_table "mtp_num_series", id: :integer, default: -> { "nextval('\"MTP_NUMSERIE_ID_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "serie", limit: 6, null: false
    t.integer "vaso_id"
  end

  create_table "mtpds_num_series", id: :integer, default: -> { "nextval('\"MTP_NUMSERIE_DISPSEG_id_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "serie", limit: 100, null: false
    t.integer "disp_seguranca_id"
  end

  create_table "phs", id: :integer, default: -> { "nextval('profissional_habilitado_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "nome", limit: 50, null: false
    t.string "crea", limit: 20, null: false
    t.string "endereco", limit: 75
    t.string "cidade", limit: 60
    t.string "uf", limit: 20
    t.string "fone", limit: 65
    t.string "cep", limit: 20
    t.string "titulo", limit: 20
    t.string "bairro", limit: 25
    t.string "cpf", limit: 20
    t.string "rg", limit: 20
    t.string "email", limit: 80
  end

  create_table "potencial_riscos", id: :integer, default: -> { "nextval('\"POTENCIAL_RISCO_id_seq\"'::regclass)" }, force: :cascade do |t|
    t.integer "potencial_risco"
    t.string "descricao", limit: 45
  end

  create_table "tipo_compressors", id: :integer, default: -> { "nextval('tipo_compressor_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "tipo_compressor", limit: 25, null: false
  end

  create_table "tipo_dispositivo_segurancas", id: :integer, default: -> { "nextval('\"TIPO_DISPOSITIVO_SEGURANCA_ID_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "nome", limit: 50, null: false
    t.string "descricao", limit: 100
  end

  create_table "tipo_drenos", id: :integer, default: -> { "nextval('tipo_dreno_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "tipo_dreno", limit: 25, null: false
  end

  create_table "tipo_inspecaos", id: :integer, default: -> { "nextval('\"TIPO_INSPECAO_ID_seq\"'::regclass)" }, force: :cascade do |t|
    t.string "nome", limit: 100
  end

  create_table "tipo_vasos", id: :integer, default: -> { "nextval('tipo_vaso_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "tipo_vaso", limit: 45, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "nome", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vasos", id: :integer, default: -> { "nextval('vaso_pressao_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "fabricante", null: false
    t.string "num_serie", limit: 15, null: false
    t.integer "categoria", default: 5, null: false
    t.date "dt_fabricacao_reconstituicao", default: -> { "CURRENT_DATE" }, null: false
    t.integer "tipo_compressor", default: 1, null: false
    t.float "volume", default: 0.0, null: false
    t.integer "empresa_proprietaria", null: false
    t.integer "tipo_dreno", default: 0, null: false
    t.float "p_inf_operacao_fabricante"
    t.float "p_sup_operacao_fabricante"
    t.float "pmta_original"
    t.float "pth_original"
    t.float "pmta_atual"
    t.float "pth_atual"
    t.text "observacoes"
    t.decimal "RELATORIO_INSPECAO_INICIAL", precision: 10, default: "-1", null: false
    t.integer "tipo_vaso", default: 0, null: false
    t.float "p_projeto"
    t.integer "idcodigo_construcao", default: 10, null: false
    t.boolean "bsem_data_fabricacao", default: false, null: false
    t.date "DATA_INSTALACAO_VASO"
    t.integer "FKTIPO_FLUIDO_SERVICO_ATUAL", default: 0, null: false
    t.integer "FKTIPO_POTENCIAL_RISCONR13", default: 4, null: false
    t.integer "FKTIPO_CLASSE_FLUIDO_ATUAL", default: 2, null: false
    t.integer "FKTIPO_DISPOSITIVO_SEGURANCA", default: 0, null: false
    t.float "TEMP_MIN_PROJETO"
    t.float "TEMP_MAX_PROJETO"
    t.integer "FKMATERIAL_CORPO_VASO", default: 0, null: false
    t.string "EFICIENCIA_SOLDA_TAMPOS", limit: 5
    t.string "EFICIENCIA_SOLDA_COSTADO", limit: 5
    t.string "EFICIENCIA_SOLDA_COSTADO_TAMPO", limit: 5
    t.float "perimetro_diametro_externo"
    t.float "entre_soladas_corpo"
    t.float "profundidade_tampo"
    t.float "esp_projeto_corpo"
    t.float "esp_projeto_tampo"
    t.string "setor_instalacao_vaso", limit: 50
    t.string "path_plaqueta_original", limit: 100, default: "fig/fabricante_numserie/plaqueta.jpg"
    t.string "path_plaqueta_atual", limit: 100, default: "fig/fabricante_numserie/plaqueta_atual.jpg"
    t.binary "foto_plaqueta"
    t.float "diametro_externo_corpo"
  end

  add_foreign_key "MEDIDA_ESPESSURA_VASO", "cadastros", column: "empresainspetora_id", name: "MEDIDA_ESPESSURA_VASO_empresainspetora_id_fkey"
  add_foreign_key "MEDIDA_ESPESSURA_VASO", "instrumento_padraos", column: "instrumentopadrao_id", name: "MEDIDA_ESPESSURA_VASO_instrumentopadrao_id_fkey"
  add_foreign_key "MEDIDA_ESPESSURA_VASO", "instrumento_padraos", column: "instrumentopadrao_id", name: "MEDIDA_ESPESSURA_VASO_instrumentopadrao_id_fkey1"
  add_foreign_key "MEDIDA_ESPESSURA_VASO", "vasos", column: "VASO", name: "MEDIDA_ESPESSURA_VASO_VASO_fkey"
  add_foreign_key "MEDIDA_ESPESSURA_VASO", "vasos", column: "VASO", name: "MEDIDA_ESPESSURA_VASO_VASO_fkey1"
  add_foreign_key "RELATORIO_INSPECAO", "ambiente_insts", column: "tipo_ambiente_instalacao_vaso_pressao", name: "RELATORIO_INSPECAO_tipo_ambiente_instalacao_vaso_pressao_fkey"
  add_foreign_key "RELATORIO_INSPECAO", "cadastros", column: "id_empresa_inspetora", name: "sys_fk_187"
  add_foreign_key "RELATORIO_INSPECAO", "cadastros", column: "id_empresa_vaso_instalado", name: "sys_fk_181"
  add_foreign_key "RELATORIO_INSPECAO", "phs", column: "idph", name: "sys_fk_178"
  add_foreign_key "RELATORIO_INSPECAO", "tipo_inspecaos", column: "TIPO_INSPECAO", name: "sys_fk_334"
  add_foreign_key "RELATORIO_INSPECAO", "vasos", column: "id_vaso_pressao", name: "RELATORIO_INSPECAO_id_vaso_pressao_fkey"
  add_foreign_key "RELATORIO_INSPECAO", "vasos", column: "id_vaso_pressao", name: "sys_fk_175"
  add_foreign_key "RELATORIO_INSP_VAL_SEG_E_ALIVIO", "cadastros", name: "RELATORIO_INSP_VAL_SEG_E_ALIVIO_cadastro_id_fkey"
  add_foreign_key "RELATORIO_INSP_VAL_SEG_E_ALIVIO", "cadastros", name: "RELATORIO_INSP_VAL_SEG_E_ALIVIO_cadastro_id_fkey1"
  add_foreign_key "RELATORIO_INSP_VAL_SEG_E_ALIVIO", "fluido_calibracao_valv_segs", column: "fluido_calibracao_id", name: "RELATORIO_INSP_VAL_SEG_E_ALIVIO_fluido_calibracao_id_fkey"
  add_foreign_key "RELATORIO_INSP_VAL_SEG_E_ALIVIO", "instrumento_padraos", column: "manometro_padrao_id", name: "RELATORIO_INSP_VAL_SEG_E_ALIVIO_manometro_padrao_id_fkey"
  add_foreign_key "RELATORIO_INSP_VAL_SEG_E_ALIVIO", "vasos", column: "vaso_pressao_protegido_id", name: "RELATORIO_INSP_VAL_SEG_E_ALIVIO_vaso_pressao_protegido_id_fkey"
  add_foreign_key "cadastros", "corps", name: "sys_fk_634"
  add_foreign_key "disp_segurancas", "cadastros", name: "dispsegurancas_fabricante_id_fkey"
  add_foreign_key "disp_segurancas", "tipo_dispositivo_segurancas", name: "dispsegurancas_modelodispseg_id_fkey"
  add_foreign_key "vasos", "cadastros", column: "fabricante", name: "sys_fk_56"
  add_foreign_key "vasos", "catnr13s", column: "categoria", name: "sys_fk_86"
  add_foreign_key "vasos", "classe_fluidos", column: "FKTIPO_CLASSE_FLUIDO_ATUAL", name: "sys_fk_286"
  add_foreign_key "vasos", "codigo_construcaos", column: "idcodigo_construcao", name: "sys_fk_145"
  add_foreign_key "vasos", "fluido_servicos", column: "FKTIPO_FLUIDO_SERVICO_ATUAL", name: "sys_fk_249"
  add_foreign_key "vasos", "materials", column: "FKMATERIAL_CORPO_VASO", name: "sys_fk_324"
  add_foreign_key "vasos", "potencial_riscos", column: "FKTIPO_POTENCIAL_RISCONR13", name: "sys_fk_255"
  add_foreign_key "vasos", "tipo_compressors", column: "tipo_compressor", name: "sys_fk_89"
  add_foreign_key "vasos", "tipo_dispositivo_segurancas", column: "FKTIPO_DISPOSITIVO_SEGURANCA", name: "sys_fk_312"
  add_foreign_key "vasos", "tipo_drenos", column: "tipo_dreno", name: "sys_fk_79"
  add_foreign_key "vasos", "tipo_vasos", column: "tipo_vaso", name: "sys_fk_117"
end
