Rails.application.routes.draw do

  devise_for :users

  root to: 'dashboard#index'
    
  #root to: 'pictures#index'
  
  resources :dashboard,only: [:index]  

  delete '/pictures/:id' => 'pictures#destroy', as: 'deatroy_pictures'
  get 'pictures/list', :controller => 'pictures', :action => 'list'
  resources :pictures,only: [:list, :new, :create, :edit, :update]
  
end
