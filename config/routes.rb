Rails.application.routes.draw do
  require 'sidekiq/web'

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, :controllers => { :omniauth_callbacks => 'omniauth_callbacks' }

  resources :users,      :only => [:index] do
    get :search, :on => :collection
  end
  resource  :avatar,     :only => [:edit, :update]
  resources :identities, :only => [:index, :destroy]

  root :to => 'welcome#index'
end
