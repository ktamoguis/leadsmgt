Rails.application.routes.draw do
  resources :industries
  resources :regions
  resources :leads
  resources :agents
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
