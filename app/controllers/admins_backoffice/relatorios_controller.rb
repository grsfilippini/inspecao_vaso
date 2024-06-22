class AdminsBackoffice::RelatoriosController < AdminsBackofficeController
  include SharedMethods
  
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
    @para_imprimir = FALSE
  end
  
  def para_imprimir
    @relatorios = Relatorio.relatorios_para_imprimir(params[:page])
    @nome_rel = 'para Impressão'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
    @em_aberto = FALSE
    @para_imprimir = TRUE
  end
  
  def em_aberto
    @relatorios = Relatorio.relatorios_em_aberto(params[:page])
    @nome_rel = 'em Aberto (rascunho)'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
    @em_aberto = TRUE
    @para_imprimir = FALSE
  end

  def pesquisa    
    @relatorios = Relatorio.pesquisa_serie_prop(params[:page], params[:num_serie], params[:proprietaria_id])
    @nome_rel = 'Concluídos (pesquisa)'
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
    @em_aberto = FALSE
    @para_imprimir = FALSE
  end
  
  def index_vence_vaso
    @status = params[:status]
    if @status.nil? 
      @status = 'nova_venda_em_aberto'
    end
    if @status == 'nova_venda_em_aberto'
      @relatorios = Relatorio.where(nova_venda_fora_lista: false, nova_venda_aguarda_resposta: false, nova_venda_fazer_inspecao: false).order(:dt_prox_insp_externa).page(params[:page]).per(20)
      @total_relatorios = Relatorio.where(nova_venda_fora_lista: false, nova_venda_aguarda_resposta: false, nova_venda_fazer_inspecao: false).count
    elsif @status == 'nova_venda_aguarda_resposta'
      @relatorios = Relatorio.where(nova_venda_aguarda_resposta: true).order(:dt_prox_insp_externa).page(params[:page]).per(20)
      @total_relatorios = Relatorio.where(nova_venda_aguarda_resposta: true).count
    elsif @status == 'nova_venda_fazer_inspecao'
      @relatorios = Relatorio.where(nova_venda_fazer_inspecao: true).order(:dt_prox_insp_externa).page(params[:page]).per(20)
      @total_relatorios = Relatorio.where(nova_venda_fazer_inspecao: true).count
    elsif @status == 'nova_venda_fora_lista'
      @relatorios = Relatorio.where(nova_venda_fora_lista: true).order(:dt_prox_insp_externa).page(params[:page]).per(20)
      @total_relatorios = Relatorio.where(nova_venda_fora_lista: true).count
    end
    
    @nome_rel = 'Vendas'

    respond_to do |format|
      format.html # index_vence_vaso.html.erb
      format.json { render json: @relatorios }
    end
  end

  def nova_venda
    @relatorio = Relatorio.find(params[:id])
  end

  def update_nova_venda
    @relatorio = Relatorio.find(params[:id])
    if @relatorio.update(nova_venda_params)
      redirect_to admins_backoffice_index_vence_vaso_path(format: :html), notice: 'Venda atualizada com sucesso.'
                  
    else
      puts @relatorio.errors.full_messages
      render :nova_venda
    end
  end


  def new    
    @relatorio = Relatorio.new
    # Verifica se o parâmetro sel_relatorio_id está presente e não é nil
    # sel_relatorio_id contém dados a serem usados neste novo relatório
    if params[:sel_relatorio_id].present? && params[:sel_relatorio_id] != nil      
      # Faça suas atribuições aqui usando o valor de sel_relatorio_id
      relatorio_base = Relatorio.find(params[:sel_relatorio_id])
      attributes_to_assign = relatorio_base.attributes.except("id", "data_relatorio", "b_rascunho", "avaliadoph", "brel_impresso")  # Excluindo o campo "id"
      @relatorio.assign_attributes(attributes_to_assign)      
    end
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
      if params[:btn_gravar]
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
    @ambiente_insts = AmbienteInst.order(:ambiente)
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
    @ultimo_rel = Relatorio.where(vaso_id: @relatorio.vaso_id).order(id: :desc).offset(1).first
    if @ultimo_rel.nil? 
      @ultimo_rel = Relatorio.new
      @ultimo_rel.dt_prox_insp_interna = Date.today
      @ultimo_rel.dt_prox_teste_hidrostatico = Date.today
      @ultimo_rel.dt_prox_insp_interna_dispositivo_seguranca = Date.today      
    end
  end

  #***********
  # PRONTUÁRIO
  #***********
  def imprime_registro_inspecao
    
    @relatorio = Relatorio.find(params[:id])
    @vaso = @relatorio.vaso
    
    respond_to do |format|
      format.html{          
      }

      format.pdf do      
        if params[:b_assinar] == 'false'
          render template: 'admins_backoffice/relatorios/imprime_registro_inspecao_pdf',
                  pdf: 'registro_inspecao',
                  locals: { asset_path: "#{Rails.root.join('app/assets/images')}" },
                  disposition: 'inline',
                  layout: 'recorte_pdf.html',
                  page_size: 'A4'
        else
          path_doc_assinado = gera_pdf_empresa_equipamento_assinado(current_admin, @relatorio.vaso.proprietaria, @relatorio.vaso, "admins_backoffice/relatorios/imprime_registro_inspecao_pdf", "registro_inspecao_assinado.pdf", "recorte_pdf.html", "Portrait")
          send_file path_doc_assinado, type: 'application/pdf', disposition: 'attachment'
        end

      end
    end

  end

  def update   
    
    if (params[:relatorio][:remove_foto_antes]      == '1' || params[:relatorio][:remove_foto_antes]      == 'true')
      @relatorio.update_attribute(:foto_antes_inspecao, nil)          
    end
    if (params[:relatorio][:remove_foto_pos]        == '1' || params[:relatorio][:remove_foto_pos]        == 'true')
      @relatorio.update_attribute(:foto_pos_inspecao, nil)          
    end
    if (params[:relatorio][:remove_foto_corpo]      == '1' || params[:relatorio][:remove_foto_corpo]      == 'true')
      @relatorio.update_attribute(:foto_corpo, nil)     
    end
    if (params[:relatorio][:remove_foto_instalacao] == '1' || params[:relatorio][:remove_foto_instalacao] == 'true')
      @relatorio.update_attribute(:foto_instalacao, nil)
    end
    if (params[:relatorio][:remove_foto_th]         == '1' || params[:relatorio][:remove_foto_th]         == 'true')
      @relatorio.update_attribute(:foto_th, nil)          
    end
    if (params[:relatorio][:remove_foto_interna1]   == '1' || params[:relatorio][:remove_foto_interna1]   == 'true')
      @relatorio.update_attribute(:foto_interna1, nil)          
    end
    if (params[:relatorio][:remove_foto_interna2]   == '1' || params[:relatorio][:remove_foto_interna2]   == 'true')
      @relatorio.update_attribute(:foto_interna2, nil)          
    end
    if (params[:relatorio][:remove_foto_interna3]   == '1' || params[:relatorio][:remove_foto_interna3]   == 'true')
      @relatorio.update_attribute(:foto_interna3, nil)          
    end
    if (params[:relatorio][:remove_foto_interna4]   == '1' || params[:relatorio][:remove_foto_interna4]   == 'true')
      @relatorio.update_attribute(:foto_interna4, nil)          
    end

    params[:relatorio].delete(:remove_foto_antes)      if params[:relatorio].key?(:remove_foto_antes)
    params[:relatorio].delete(:remove_foto_pos)        if params[:relatorio].key?(:remove_foto_pos)
    params[:relatorio].delete(:remove_foto_corpo)      if params[:relatorio].key?(:remove_foto_corpo)
    params[:relatorio].delete(:remove_foto_instalacao) if params[:relatorio].key?(:remove_foto_instalacao)
    params[:relatorio].delete(:remove_foto_th)         if params[:relatorio].key?(:remove_foto_th)
    params[:relatorio].delete(:remove_foto_interna1)   if params[:relatorio].key?(:remove_foto_interna1)
    params[:relatorio].delete(:remove_foto_interna2)   if params[:relatorio].key?(:remove_foto_interna2)
    params[:relatorio].delete(:remove_foto_interna3)   if params[:relatorio].key?(:remove_foto_interna3)
    params[:relatorio].delete(:remove_foto_interna4)   if params[:relatorio].key?(:remove_foto_interna4)

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
  if params[:btn_gravar_sair] || params[:btn_gravar_avaliacaoph] || params[:btn_gravar]
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

  def inicia_inspecao_proprietario
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false).order(:nome_curto)
  end

  def get_relatorios_by_vaso
    vaso_id = params[:vaso_id]
    relatorios = Relatorio.where(vaso_id: vaso_id).order(id: :desc)    
    render json: relatorios.select(:id, :data_relatorio, :user_id, :tipo_inspecao_id, :art_id, :ph_id, :cidade_id, :vaso_id, :finalidade_vaso_id, :proprietaria_id, :inspetora_id).as_json
  end  

  def marcar_como_impresso
    @relatorio = Relatorio.find(params[:id])
    @relatorio.update(brel_impresso: true)
    redirect_to admins_backoffice_relatorio_para_impressao_path, notice: "Relatório marcado como impresso."
  end

  ##########
  # PRIVATE
  ##########
  private
    def set_relatorio
      @relatorio = Relatorio.find(params[:id])      
    end
   
    def nova_venda_params
      params.require(:relatorio).permit(:id,
                                        :nova_venda_obs,
                                        :nova_venda_aguarda_resposta,
                                        :nova_venda_fora_lista,
                                        :nova_venda_fazer_inspecao)
    end

    def params_relatorio
      if params.key?(:relatorio) && !params[:relatorio].empty?
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
                                          :inspetor_id,
                                          
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
                                          :serv_contratado_dispseg_calibracao,
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
                                          :bman_foifeito_ajuste,
                                          :bman_foifeita_calibracao,
                                          :manometro_observacoes,
                                          
                                          # Inspeção do dispositivo de segurança
                                          :possui_dispositivo_deseguranca,
                                          :bBloqueioInadvertidoIntencionalDoDispSeg,
                                          :possui_dispositivo_contra_bloqueio_dodisp_seg,
                                          :bdispseg_foisubstituido,
                                          :bdispseg_foifeito_ajuste,
                                          :dispositivoseg_observacoes,
                                          :dispositivoseg_pabertura,
                                          
                                          # Inspeção do pressostato
                                          :bpressostato_existe,
                                          :bpressostato_ehmantido_calibrado_eemboas_condicoes_operacao,
                                          :bpressostato_foisubstituido,
                                          :bpressostato_foifeito_ajuste,
                                          :bpressostato_foiverificada_faixadetrabalho,
                                          :pressostato_pliga,
                                          :pressostato_pdesliga,
                                          :pressostato_observacoes,
                                          
                                          # Existe dreno
                                          :bdreno_existe,
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
                                          :dt_prox_insp_interna_dispositivo_seguranca,

                                          # nova venda
                                          :nova_venda_obs,
                                          :nova_venda_aguarda_resposta,
                                          :nova_venda_fora_lista,
                                          :nova_venda_fazer_inspecao
      #t.boolean "brevisado", default: false, null: false
      #t.boolean "benviada_placa_local_para_confeccao", default: false
                                    )
      else        
      end
    end
    
    def get_relacoes
      @users              = User.order(:nome).order(:sobrenome)
      @tipo_inspecaos     = TipoInspecao.order(:nome)
      @arts               = Art.includes(:cadastro).order(id: :desc)
      @phs                = Ph.order(:nome)
      @cidades            = Cidade.order(:nome)
      @vasos              = Vaso.includes(:fabricante).order(:num_serie)
      @finalidade_vasos   = FinalidadeVaso.all
      @proprietarias      = Cadastro.order(:nome_curto)
      @inspetoras         = Cadastro.where(eh_empresa_inspetora: true).order(:nome_curto)      
    end
  
end
