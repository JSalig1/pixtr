Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"

  root "homes#show"

  resource :dashboard, only: [:show]

  resources :galleries do
    member do 
      post "like" => "gallery_likes#create"
      delete "unlike" => "gallery_likes#destroy"
    end
    resources :images, only: [:new, :create]
  end

  resources :charges, only: [:new, :create]

  get 'tags/:tag', to: 'images#index', as: :tag

  get '/search', to: 'searches#index'

  resources :groups, only: [:index, :new, :create, :show] do
    member do
      post "join" => "group_memberships#create"
      delete "leave" => "group_memberships#destroy"
    end
    member do
      post "like" => "group_likes#create"
      delete "unlike" => "group_likes#destroy"
    end
  end

  resources :comments, only: [:destroy]

  resources :images, except: [:index, :new, :create] do
    resources :comments, only: [:create]
    member do
      post "like" => "image_likes#create"
      delete "unlike" => "image_likes#destroy"
    end
  end

  resources :users, only: [:show] do
    member do
      post "/follow" => "following_relationships#create"
      delete "/unfollow" => "following_relationships#destroy"
    end

    collection do
      get "/following" => "following_relationships#index"
      get "/followers" => "following_relationships#index"
    end
  end
end
