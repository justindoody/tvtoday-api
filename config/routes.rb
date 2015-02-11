Rails.application.routes.draw do
  root 'landing_page#index'

  namespace :api do
    resources :shows, only: [:index, :new, :create]

    root  'shows#index'
    post  'sync',           to: 'shows#sync'
    get   'tvdbid/:id',     to: 'shows#tvdbid',       as: :tvdbid
    get   'shows_updated',  to: 'shows#last_updated', as: :last_updated
    get   'update_all',     to: 'shows#update_all',   as: :update_all_shows
  end

  # Solo admin user, new and destroy refers to a session
  get    'login',    to: 'user#new'
  delete 'logout',   to: 'user#destroy'
  resources :user, only: [:new, :create, :destroy]

end
