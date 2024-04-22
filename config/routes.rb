Rails.application.routes.draw do
  get 'weekly_sessions/index'
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    registrations: 'admin/registrations'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_scope :admin do
    get '/admin/sign_out' => 'admin_auth/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
  resources :home


  namespace :users do
    resources :profiles
  end

  resources :weekly_sessions
  resources :work_sessions, only: [:index]
  post 'work_sessions/punch_in', to: 'work_sessions#punch_in', as: 'punch_in_work_sessions'
  post 'work_sessions/punch_out', to: 'work_sessions#punch_out', as: 'punch_out_work_sessions'

  namespace :admin do
    resources :users, only: [:index, :show, :new, :create, :destroy]  # Admin can view all users, add new ones, and delete users
  end
end
