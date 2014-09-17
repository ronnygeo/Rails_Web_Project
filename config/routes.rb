Rails.application.routes.draw do
  resources :package_lines

  resources :packages

  resources :socials

  resources :images

  mount RailsAdmin::Engine => '/adm', as: 'rails_admin'

  #authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/skiq'
    require 'sidetiq/web'
  #end

#  resources :payments

  concern :locatable do
    resources :locations
  end

  concern :reviewable do
    resources :reviews
  end

  #resources :ads

  resources :listings, concerns: [:locatable, :reviewable]

  resources :events, concerns: [:locatable, :reviewable]

  resources :clients

  resources :places, concerns: [:locatable, :reviewable]

=begin
  resources :categories do
    resources :subcategories
  end
=end

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  get 'pages/home'

  get 'pages/contact'

  get 'pages/about'

  get 'pages/package'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'pages#home'

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

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  get '/discourse/sso' => 'discourse_sso#sso'

  #get '/clients/:id/addItems' => 'clients#addItems', via: [:get, :patch], :as => :addItems
end
