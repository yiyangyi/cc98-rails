Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  get "search" => 'search#index', as: :search

  resources :sites
  resources :comments
  resources :nodes
  resources :photos
  resources :likes

  resources :notes do
    collection do
      post :preview
    end
  end

  resources :notifications, only: [:index, :destroy] do
    collection do
      post :clean
    end
  end

  get "topics/node:id" => "topics#node", as: :node_topics
  get "topics/node:id/feed" => "topics#node_feed", as: :node_feed
  get "topics/last" => "topics#last", as: :recent_topics
  resources :topics do
    member do
      post :reply
      post :favorite
      delete :unfavorite
      post :follow
      delete :unfollow
      patch :suggest
      delete :unsuggest
    end

    collection do
      get :no_reply
      get :poplular
      get :excellent
      get :preview
      get :feed, default: { format: 'xml' }
    end
  end

  namespace :cpanel do
    root to: "home#index"
    resources :users
    resources :sections
    resources :nodes
    resources :topics do
      member do
        post :suggest
        post :unsuggest
        post :undestroy
      end
    end
    resources :photos
    resources :comments
  end

  match '*path', to: 'home#404', via: :all
end
