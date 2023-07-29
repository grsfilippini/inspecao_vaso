Rails.application.routes.draw do
  
  # Name space, define agrupamento de pastas em controllers e views
  # Pode-se referir a estes agrupamentos através de :admins_backoffice por exemplo
  namespace :admins_backoffice do
    get 'welcome/index' # Chama o dashboard (painel principal do admins_backoffice)
    post 'ajusta_estatisticas', to: 'ajusta_estatisticas#estatisticas'
    #get 'admins/index'
    #get 'admins/edit:id', to: 'admins#edit'
    # Substitui-se as declarações acima por:
    # Isso cria várias rotas padronizadas.
    resources :admins, except: [:delete] # Chama procedimentos dos administradores
    resources :users    
    resources :empresas
    
    # only diz para gerar somente as rotas especificadas
    # , except: [:destroy, :new] -> diz para não criar as rotas especificadas
    # , only: [:destroy, :new] -> diz para criar as rotas especificadas        
    resources :corps
    resources :cadastros
    get 'pesquisa_cadastro', to: 'cadastros#pesquisa'
    resources :cidades
    resources :catnr13s
    resources :finalidade_vasos    
    resources :vasos do
      member do
        get :json_data, defaults: { format: 'json' }
      end
    end   
    get 'pesquisa_vaso', to: 'vasos#pesquisa'    
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
    resources :fluido_calibracao_valv_segs
    resources :fluido_servicos
    resources :instrumento_padraos
    resources :materials    
    resources :mtp_num_series
    resources :mtpds_num_series
    resources :potencial_riscos
    resources :tipo_inspecaos
    resources :tipo_vasos    
    resources :relatorios
    get 'relatorio_para_impressao',  to: 'relatorios#para_imprimir'
    get 'relatorio_em_aberto',       to: 'relatorios#em_aberto'
    get 'pesquisa_relatorio',        to: 'relatorios#pesquisa'
    get 'inspecao_doc_existente',    to: 'relatorios#inspecao_doc_existente'
    get 'inspecao_verif_iniciais',   to: 'relatorios#inspecao_verif_iniciais'
    get 'inspecao_insp_contratadas', to: 'relatorios#inspecao_insp_contratadas'
    get 'inspecao_insp_normas',      to: 'relatorios#inspecao_insp_normas'
    get 'inspecao_insp_instalacoes', to: 'relatorios#inspecao_insp_instalacoes'
    get 'inspecao_insp_manometro',   to: 'relatorios#inspecao_insp_manometro'
    get 'inspecao_insp_dispseg',     to: 'relatorios#inspecao_insp_dispseg'
    get 'inspecao_insp_pressostato', to: 'relatorios#inspecao_insp_pressostato'
    get 'inspecao_insp_dreno',       to: 'relatorios#inspecao_insp_dreno'
    get 'inspecao_insp_vaso_outros', to: 'relatorios#inspecao_insp_vaso_outros'
    get 'inspecao_fotos',            to: 'relatorios#inspecao_fotos'

    resources :relatorio_dispsegs
    get 'pesquisa_relatorio_dispseg', to: 'relatorio_dispsegs#pesquisa'
    get 'relatorio_dispseg_impresso', to: 'relatorio_dispsegs#impresso'
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
  end  

  # O skip abaixo é para não criar a rota sign_up padrão do devise.
  # Não foi removido o módulo registrable, todos recursos internos ficam ativados, exceto a rota.
  # O sign_up foi implementado como admins_backoffice/admins/new.
  devise_for :admins, skip: [:registrations]
  devise_for :users
  devise_for :empresas

  get 'inicio', to: 'site/welcome#index'
  root          to: 'site/welcome#index'
  get 'admin',  to: 'admins_backoffice/welcome#index'
  get 'empresa',to: 'empresas_backoffice/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end