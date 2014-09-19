Rails.application.routes.draw do
  require 'sidekiq/web'

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, :controllers => { :omniauth_callbacks => 'omniauth_callbacks' }

  resources :users, :only => [:index] do
    resources :identities, :only => [:index, :destroy]
  end

  root :to => 'welcome#index'
end
