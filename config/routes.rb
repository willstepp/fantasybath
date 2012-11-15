Fantasybath::Application.routes.draw do
	scope '/workshop' do
        match '/' => 'workshop#index', :via => :get, :as => :workshop
        resources :scents
        resources :products

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
        match '/create_product_type' => 'products#create_product_type', :via => :post, :as => :create_product_type
        match '/update_product_type' => 'products#update_product_type', :via => :put, :as => :update_product_type
        match '/destroy_product_type' => 'products#destroy_product_type', :via => :delete, :as => :destroy_product_type
	end
    match '/bathtub' => 'bath_tub#index', :via => :get, :as => :bathub
    root :to =>  "home#index"
end