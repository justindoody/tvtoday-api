Rails.application.routes.draw do
  root 'landing_page#index'

  namespace :api do
    root 'shows#index'

    resources :shows, only: [:index, :new, :create]
    post 'sync', to: 'shows#sync'
    post 'search', to: 'shows#search'
    get 'tvdbid/:id', to: 'shows#tvdbid', as: :tvdbid
    get 'shows_updated', to: 'shows#last_updated', as: :last_updated
    get 'update_all', to: 'shows#update_all', as: :update_all_shows
  end

  delete 'logout', to: 'session#destroy'

  mount Lockup::Engine, at: '/lockup'

end
