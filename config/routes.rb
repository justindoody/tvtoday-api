Rails.application.routes.draw do
  root 'landing_page#index'

  get 'landing_page/index'
  
  get 'api/tvdbid/:id', to: 'api#tvdbid', as: :tvdbid
  get 'api/name/:id', to: 'api#name', as: :name

  get 'parse/:id', to: 'api#parse', as: :parse

  get 'api/new', to: 'api#new', as: :new
  post 'api/create', to: 'api#create', as: :create
  get 'api', to: 'api#index', as: :api_index

  get 'api/shows', to: 'api#shows_json'
  get 'api/shows_updated', to: 'api#shows_updated'

  get 'api/update_all', to: 'api#update_shows', as: :updateShows

end
