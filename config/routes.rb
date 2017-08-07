Rails.application.routes.draw do

  devise_for :users
  
  root to: 'pictures#index'
  
  
  delete '/pictures/:id' => 'pictures#destroy', as: 'deatroy_pictures'
  resources :pictures,only: [:index, :new, :create, :edit, :update]
  
end
