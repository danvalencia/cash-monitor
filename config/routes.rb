require 'api_constraints'

Cashmonitor2::Application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  devise_for :users

  devise_scope :user do
    get "/login", to: "devise/sessions#new"
    delete "/logout", to: "devise/sessions#destroy"
  end

  resources :users

  resources :maquinets

  root :to => "maquinets#index"

  get '/machines/:machine_uuid/earnings', controller: :machines, action: :earnings, defaults: {format: 'json', group_by: 'day'}
  get '/machines/:machine_uuid/sessions', controller: :sessions, action: :index

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      put  'machines/:machine_uuid/sessions/:session_uuid', to: 'sessions#update'
      post 'machines/:machine_uuid/sessions/:session_uuid', to: 'sessions#create'
      put  'machines/:machine_uuid', to: 'machines#update'
    end
  end

end
