Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount API::Base, at: '/api'

  get '/api' => redirect('/swagger/dist/index.html?url=/apidocs.json')
  resources :apidocs, only: [:index]
  
end
