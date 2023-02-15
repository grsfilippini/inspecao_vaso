Rails.application.routes.draw do
  
  # Name space, define agrupamento de pastas em controllers e views
  # Pode-se referir a estes agrupamentos através de :admins_backoffice por exemplo
  namespace :admins_backoffice do
    get 'welcome/index' # Chama o dashboard (painel principal do admins_backoffice)
    
    #get 'admins/index'
    #get 'admins/edit:id', to: 'admins#edit'
    # Substitui-se as declarações acima por:
    # Isso cria várias rotas padronizadas.
    resources :admins, except: [:delete] # Chama procedimentos dos administradores
    # only diz para gerar somente as rotas especificadas
    # , except: [:destroy, :new] -> diz para não criar as rotas especificadas
    # , only: [:destroy, :new] -> diz para criar as rotas especificadas        
    resources :cadastro_corps
    resources :cadastros
    resources :cidades
  end

  namespace :site do
    get 'welcome/index'
  end

  namespace :users_backoffice do
    get 'welcome/index'
  end

  devise_for :admins
  devise_for :users

  get 'inicio', to: 'site/welcome#index'
  root to: 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
