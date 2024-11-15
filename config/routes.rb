Rails.application.routes.draw do
  
  namespace :inspetors_backoffice do
    get 'welcome/index'
    resources :relatorios
    resources :relatorio_dispsegs
    resources :espessura_vasos
    resources :vasos do
      member do
        get :json_data, defaults: { format: 'json' }
      end
    end 
    resources :disp_segurancas
    get '/obter_ultima_serie_mtpds', to: 'disp_segurancas#obter_ultima_serie_mtpds'
    resources :cadastros do
      member do
        get :json_data, defaults: { format: 'json' }
      end
    end    
    get 'pesquisa_vaso', to: 'vasos#pesquisa'
    get '/obter_ultima_serie_mtp', to: 'vasos#obter_ultima_serie_mtp'
    get 'pesquisa_relatorio_dispseg', to: 'relatorio_dispsegs#pesquisa'
  end
  

  namespace :admins_backoffice do
    get 'inspetors/index'
  end

  # Name space, define agrupamento de pastas em controllers e views
  # Pode-se referir a estes agrupamentos através de :admins_backoffice por exemplo
  namespace :admins_backoffice do
    
    # Administração de documentos pdf gerados pelo app
    get  'administra_docs',      to: 'administra_docs#administra'
    post 'compactar_documentos', to: 'administra_docs#compactar'
    post 'apagar_documentos',    to: 'administra_docs#apagar'

    get 'welcome/index' # Chama o dashboard (painel principal do admins_backoffice)
    post 'ajusta_estatisticas', to: 'ajusta_estatisticas#estatisticas'
    #get 'admins/index'
    #get 'admins/edit:id', to: 'admins#edit'
    # Substitui-se as declarações acima por:
    # Isso cria várias rotas padronizadas.
    resources :admins, except: [:delete] # Chama procedimentos dos administradores
    resources :users    
    resources :empresas
    resources :inspetors
    

    # only diz para gerar somente as rotas especificadas
    # , except: [:destroy, :new] -> diz para não criar as rotas especificadas
    # , only: [:destroy, :new] -> diz para criar as rotas especificadas        
    resources :corps

    resources :cadastros
    get 'pesquisa_cadastro',         to: 'cadastros#pesquisa'    
    get 'pesquisa_cadastro_pdf',     to: 'cadastros#pesquisa'
    get 'imprime_cadastro_pdf/:id',  to: 'cadastros#imprime_cadastro'

    resources :cidades
    
    resources :catnr13s

    resources :espessura_vasos
    get 'pesquisa_espessura_vaso', to: 'espessura_vasos#pesquisa'
    get 'espessura_em_aberto',     to: 'espessura_vasos#em_aberto' 

    resources :finalidade_vasos    

    resources :vasos do
      member do
        get :json_data, defaults: { format: 'json' }
        #delete :remove_photo # Rota para deletar a foto do vaso
      end
    end       
    get 'pesquisa_vaso',                              to: 'vasos#pesquisa'    
    get '/obter_ultima_serie_mtp',                    to: 'vasos#obter_ultima_serie_mtp'
    get 'get_vasos_by_proprietaria/:proprietaria_id', to: 'vasos#get_vasos_by_proprietaria'
    get 'imprime_prontuario_pdf/:id',                 to: 'vasos#imprime_prontuario', as: 'vasos_imprime_prontuario'
    get 'imprime_etiqueta_pdf/:id',                   to: 'vasos#imprime_etiqueta', as: 'vasos_imprime_etiqueta'
    get 'imprime_laudo_th_pdf/:id',                   to: 'vasos#imprime_laudo_th', as: 'vasos_imprime_laudo_th'
    get 'imprime_abertura_rs_pdf/:id',                to: 'vasos#imprime_abertura_rs', as: 'vasos_imprime_abertura_rs'
    get 'imprime_plaqueta_pdf/:id',                   to: 'vasos#imprime_plaqueta', as: 'vasos_imprime_plaqueta'
    #get 'imprime_registro_inspecao_pdf/:id',          to: 'vasos#imprime_registro_inspecao', as: 'vasos_imprime_registro_inspecao'

    resources :tipo_compressors
    resources :tipo_drenos
    resources :ambiente_insts
    resources :phs
    resources :arts do
      member do
        get :json_data, defaults: { format: 'json' }
      end
    end    
    resources :classe_fluidos
    resources :codigo_construcaos
    resources :tipo_dispositivo_segurancas

    resources :disp_segurancas
    get '/obter_ultima_serie_mtpds', to: 'disp_segurancas#obter_ultima_serie_mtpds'

    resources :fluido_calibracao_valv_segs
    resources :fluido_servicos
    resources :instrumento_padraos
    resources :materials    
    resources :mtp_num_series
    resources :mtpds_num_series
    resources :potencial_riscos
    resources :tipo_inspecaos
    resources :tipo_vasos   

    resources :relatorios, except: :show do
      member do
        post 'marcar_como_impresso'
        patch :update_nova_venda
      end
    end
    get 'relatorio_para_impressao',    to: 'relatorios#para_imprimir'
    get 'relatorio_em_aberto',         to: 'relatorios#em_aberto'
    get 'pesquisa_relatorio',          to: 'relatorios#pesquisa'
    get 'imprime_registro_inspecao_pdf/:id', to: 'relatorios#imprime_registro_inspecao', as: 'relatorios_imprime_registro_inspecao'
    get 'vence_vaso',       to: 'relatorios#index_vence_vaso', as: 'index_vence_vaso'
    get 'relatorios/nova_venda/:id',   to: 'relatorios#nova_venda', as: 'nova_venda'
    # Referente aos forms de inspeção
    get 'inspecao_doc_existente',      to: 'relatorios#inspecao_doc_existente'
    get 'inspecao_verif_iniciais',     to: 'relatorios#inspecao_verif_iniciais'
    get 'inspecao_insp_contratadas',   to: 'relatorios#inspecao_insp_contratadas'
    get 'inspecao_insp_normas',        to: 'relatorios#inspecao_insp_normas'
    get 'inspecao_insp_instalacoes',   to: 'relatorios#inspecao_insp_instalacoes'
    get 'inspecao_insp_manometro',     to: 'relatorios#inspecao_insp_manometro'
    get 'inspecao_insp_dispseg',       to: 'relatorios#inspecao_insp_dispseg'
    get 'inspecao_insp_pressostato',   to: 'relatorios#inspecao_insp_pressostato'
    get 'inspecao_insp_dreno',         to: 'relatorios#inspecao_insp_dreno'
    get 'inspecao_insp_vaso_outros',   to: 'relatorios#inspecao_insp_vaso_outros'
    get 'inspecao_fotos',              to: 'relatorios#inspecao_fotos'
    get 'avaliarph/:id',               to: 'relatorios#avaliarph', as: :avaliarph
    get 'busca_um_relatorio',          to: 'relatorios#form_busca_um_relatorio'
    get 'edita_um_relatorio',          to: 'relatorios#form_edita_um_relatorio'    
    get 'preenche_intervencoes',       to: 'relatorios#preenche_intervencoes'
    get 'preenche_recomendacoes',      to: 'relatorios#preenche_recomendacoes'
    get 'preenche_rgi',                to: 'relatorios#preenche_rgi'
    get 'preenche_insp_externa',       to: 'relatorios#preenche_insp_externa'
    get 'preenche_insp_interna',       to: 'relatorios#preenche_insp_interna'
    get 'preenche_parecer_conclusivo', to: 'relatorios#preenche_parecer_conclusivo'
    get 'inicia_inspecao_proprietario',to: 'relatorios#inicia_inspecao_proprietario'
    get 'get_relatorios_by_vaso/:vaso_id', to: 'relatorios#get_relatorios_by_vaso'
    
    

    resources :relatorio_dispsegs do
      member do
        post 'marcar_como_impresso'
        post 'marcar_como_revisado'
      end
    end
    get 'pesquisa_relatorio_dispseg', to: 'relatorio_dispsegs#pesquisa'
    get 'relatorio_dispseg_impresso', to: 'relatorio_dispsegs#impresso'
    get 'relatorio_dispseg_a_imprimir', to: 'relatorio_dispsegs#a_imprimir'
    get 'inicia_inspecao_dispseg_proprietario',to: 'relatorio_dispsegs#inicia_inspecao_proprietario'
    get 'get_relatorios_dispseg_by_vaso/:vaso_id', to: 'relatorio_dispsegs#get_relatorios_by_vaso'
  end

  namespace :site do
    get 'welcome/index'
    get 'pesquisa', to: 'pesquisa#vasos'
    get 'pesq_fab_prop', to: 'pesquisa#pesq_fab_prop'
    post 'relatorios_vaso', to: 'relatorios_vaso#relatorios'    
  end

  namespace :users_backoffice do
    get 'welcome/index'
    get 'perfil', to: 'perfil#edit'
    patch 'perfil', to: 'perfil#update'
  end

  namespace :empresas_backoffice do
    get 'welcome/index'
    get 'pesquisa', to: 'welcome#pesquisa'
  end  

  # O skip abaixo é para não criar a rota sign_up padrão do devise.
  # Não foi removido o módulo registrable, todos recursos internos ficam ativados, exceto a rota.
  # O sign_up foi implementado como admins_backoffice/admins/new.
  devise_for :admins, skip: [:registrations]
  devise_for :users
  devise_for :empresas
  devise_for :inspetors

  get 'inicio', to: 'site/welcome#index'
  root          to: 'site/welcome#index'
  get 'admin',  to: 'admins_backoffice/welcome#index'
  get 'empresa',to: 'empresas_backoffice/welcome#index'
  get 'inspetor',to:'inspetors_backoffice/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end