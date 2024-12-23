Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'tickets', to: redirect('https://webtickets.com')
  resources :contact_messages, only: %i[new create] # [:new, :create]
  post 'subscribe', to: 'subscribers#create' # resources :subscribe, only: [:create] can also be used instead

  resources :events, only: %i[index show new create edit update destroy] do
    resources :images, only: %i[index show new create destroy]
  end

  devise_scope :admin do
    root to: 'events#new', as: :admin_root
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
