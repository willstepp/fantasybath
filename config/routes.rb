Fantasybath::Application.routes.draw do
  devise_for :users

  get "coupons/index"

	scope '/workshop' do
        match '/' => 'workshop#index', :via => :get, :as => :workshop
        resources :scents
        resources :products
        resources :coupons

        match '/products/:id/images' => 'products#images', :via => :get, :as => :product_images
        match '/products/:id/upload_image' => 'products#upload_image', :via => :post, :as => :upload_image
        match '/products/:id/delete_image' => 'products#delete_image', :via => :delete, :as => :delete_image

        match '/scents/:id/icon' => 'scents#icon', :via => :get, :as => :scent_icon
        match '/scents/:id/upload_icon' => 'scents#upload_icon', :via => :post, :as => :upload_icon
        match '/scents/:id/delete_icon' => 'scents#delete_icon', :via => :delete, :as => :delete_icon

        match '/products/:product_id/upgrades' => 'products#upgrades', :via => :get, :as => :upgrades
        match '/products/:product_id/upgrades/new' => 'products#new_upgrade', :via => :get, :as => :new_upgrade
        match '/products/:product_id/upgrades/create' => 'products#create_upgrade', :via => :post, :as => :create_upgrade
        match '/products/:product_id/upgrades/:id/edit' => 'products#edit_upgrade', :via => :get, :as => :edit_upgrade
        match '/products/:product_id/upgrades/:id/update' => 'products#update_upgrade', :via => :put, :as => :update_upgrade
        match '/products/:product_id/upgrades/:id/destroy' => 'products#destroy_upgrade', :via => :delete, :as => :destroy_upgrade

        match '/product_types' => 'products#product_types', :via => :get, :as => :product_types
        match '/new_product_type' => 'products#new_product_type', :via => :get, :as => :new_product_type
        match '/create_product_type' => 'products#create_product_type', :via => :post, :as => :create_product_type
        match '/edit_product_type/:id' => 'products#edit_product_type', :via => :get, :as => :edit_product_type
        match '/update_product_type' => 'products#update_product_type', :via => :put, :as => :update_product_type
        match '/destroy_product_type/:id' => 'products#destroy_product_type', :via => :delete, :as => :destroy_product_type

        match '/scent_categories' => 'scents#scent_categories', :via => :get, :as => :scent_categories
        match '/new_scent_category' => 'scents#new_scent_category', :via => :get, :as => :new_scent_category
        match '/create_scent_category' => 'scents#create_scent_category', :via => :post, :as => :create_scent_category
        match '/edit_scent_category/:id' => 'scents#edit_scent_category', :via => :get, :as => :edit_scent_category
        match '/update_scent_category' => 'scents#update_scent_category', :via => :put, :as => :update_scent_category
        match '/destroy_scent_category/:id' => 'scents#destroy_scent_category', :via => :delete, :as => :destroy_scent_category
	end
    
    match '/checkout' => 'bath_tub#checkout', :via => :get, :as => :checkout
    match '/submit_payment' => 'bath_tub#submit_payment', :via => :post, :as => :submit_payment
    
    match '/bathtub' => 'bath_tub#index', :via => :get, :as => :bathtub
    match '/bathtub_add' => 'bath_tub#add', :via => :post, :as => :bathtub_add
    match '/bathtub_update' => 'bath_tub#update', :via => :put, :as => :bathtub_update
    match '/bathtub_remove' => 'bath_tub#remove', :via => :post, :as => :bathtub_remove

    match '/:catalog_type' => 'catalog#index', :via => :get, :as => :catalog_index
    match '/scents/:id' => 'catalog#scent', :via => :get, :as => :catalog_scent
    match '/products/:id' => 'catalog#product', :via => :get, :as => :catalog_product


    root :to =>  "catalog#index"
end