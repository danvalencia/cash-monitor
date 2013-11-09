require 'api_constraints'

Cashmonitor2::Application.routes.draw do

  devise_for :users 

  devise_scope :user do
    get "/login", to: "devise/sessions#new"
    delete "/logout", to: "devise/sessions#destroy"
  end

  resources :users

  resources :maquinets

  root :to => "maquinets#index"

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      post 'machines/:machine_id/sessions/:session_id', to: 'sessions#update'
    end
  end
end
