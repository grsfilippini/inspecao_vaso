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
    # only diz para gerar somente as rotas especificadas
    # , except: [:destroy, :new] -> diz para não criar as rotas especificadas
    # , only: [:destroy, :new] -> diz para criar as rotas especificadas        
    resources :corps
    resources :cadastros
    get 'pesquisa_cadastro', to: 'cadastros#pesquisa'
    resources :cidades
    resources :catnr13s
    resources :finalidade_vasos
    resources :vasos
    get 'pesquisa_vaso', to: 'vasos#pesquisa'
    #get 'vasos/:id/imgplaqueta', to: 'vasos#plaqueta_preview', as: 'plaqueta_preview'
    resources :tipo_compressors
    resources :tipo_drenos
    resources :ambiente_insts
    resources :phs
    resources :arts
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
    resources :users
    resources :relatorios
    get 'relatorio_para_impressao', to: 'relatorios#para_imprimir'
    get 'relatorio_em_aberto', to: 'relatorios#em_aberto'
    get 'pesquisa_relatorio', to: 'relatorios#pesquisa'
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

  # O skip abaixo é para não criar a rota sign_up padrão do devise.
  # Não foi removido o módulo registrable, todos recursos internos ficam ativados, exceto a rota.
  # O sign_up foi implementado como admins_backoffice/admins/new.
  devise_for :admins, skip: [:registrations]
  
  devise_for :users

  get 'inicio', to: 'site/welcome#index'
  root          to: 'site/welcome#index'
  get 'admin',  to: 'admins_backoffice/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end