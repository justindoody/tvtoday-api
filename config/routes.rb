Rails.application.routes.draw do
  root 'landing_page#index'

  get 'landing_page/index'
  
  get 'api/tvdbid/:id', to: 'api#tvdbid', as: :tvdbid
  get 'api/name/:id', to: 'api#name', as: :name

  get 'parse/:id', to: 'api#parse', as: :parse

end
