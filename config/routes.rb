Server::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => 'omniauth_callbacks' }

  resources :users, :only => [:index] do
    resources :identities, :only => [:destroy]
  end

  root :to => 'welcome#index'
end
