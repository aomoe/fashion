Rails.application.routes.draw do
  get "likes/create"
  get "likes/destroy"
  # Devise routes for user authentication
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    confirmations: "users/confirmations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get 'users/change_email', to: 'users/email_changes#new', as: :change_email
    patch 'users/change_email', to: 'users/email_changes#create'
    get 'users/confirm_email/:confirmation_token',
        to: 'users/email_changes#confirm', as: :confirm_email_change
  end

  # devise_scope :user do
  #   get "users/sign_in", to: "users/sessions#new", as: :new_user_session
  #   post "users/sign_in", to: "users/sessions#create", as: :user_session
  #   delete "users/sign_out", to: "users/sessions#destroy", as: :destroy_user_session
  #   get "users/sign_out", to: "users/sessions#destroy"
  #   get "users/sign_up", to: "users/registrations#new", as: :new_user_registration
  #   post "users", to: "users/registrations#create", as: :user_registration
  #   get "users/edit", to: "users/registrations#edit", as: :edit_user_registration
  #   put "users", to: "users/registrations#update"
  #   delete "users", to: "users/registrations#destroy"
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root to: "home#top"
  resources :posts do
    resource :like, only: [:create, :destroy]
    collection do
      get :search
    end
  end
  get "mypage", to: "users#show"
end
