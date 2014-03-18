Pixtr::Application.routes.draw do
  
  
  get "/galleries/random" => "random_galleries#show"  #<--- new controller same model! :) stick to same 7 actions for all and no additional!
  
  root "homes#show"
  # root "galleries#index" #same as -- get "/" => "galleries#index"
  
  resources :galleries do #replaces all lines below and also includes an additional root route.  got to rails.info for route list
  # get "/galleries/new" => "galleries#new"
  # get "/galleries/:id" => "galleries#show", as: :gallery
  # post "/galleries" => "galleries#create"
  # get "/galleries/:id/edit" => "galleries#edit"
  # patch "/galleries/:id" => "galleries#update"
  # delete "/galleries/:id" => "galleries#destroy"
    
    resources :images, only: [:new, :create] #better practices, being specific keeps your routes file short and concise!  use only: and except:
    # resources :images, shallow: true  #nested this within resources :galleries by nesting it in a block.  this nests the urls within gallery urls
                                      #shallow method eliminates galleries from url where it is not needed, e.g. all but new and create for images
  end
  
  resources :images, except: [:index, :new, :create] do
    resources :comments, only: [:create]  #no :new bc we don't need a form for a new comment
  end


  
end
  
  
  
  
  
  
  
  
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
