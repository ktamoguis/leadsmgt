Rails.application.routes.draw do

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/signout' => 'sessions#destroy'

  resources :industries
  resources :regions
  resources :leads
  resources :agents
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
