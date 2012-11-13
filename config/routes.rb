Fantasybath::Application.routes.draw do
	scope '/workshop' do
    match '/' => 'workshop#index', :via => :get, :as => :workshop

		resources :scents
  	resources :products

    match '/products/:id/images' => 'products#images', :via => :get, :as => :product_images
    match '/products/:id/upload_image' => 'products#upload_image', :via => :post, :as => :upload_image
    match '/products/:id/delete_image' => 'products#delete_image', :via => :delete, :as => :delete_image

    match '/products/:product_id/upgrades' => 'products#upgrades', :via => :get, :as => :upgrades
    match '/products/:product_id/upgrades/new' => 'products#new_upgrade', :via => :get, :as => :new_upgrade
    match '/products/:product_id/upgrades/create' => 'products#create_upgrade', :via => :post, :as => :create_upgrade
    match '/products/:product_id/upgrades/:id/edit' => 'products#edit_upgrade', :via => :get, :as => :edit_upgrade
    match '/products/:product_id/upgrades/:id/update' => 'products#update_upgrade', :via => :put, :as => :update_upgrade
    match '/products/:product_id/upgrades/:id/destroy' => 'products#destroy_upgrade', :via => :delete, :as => :destroy_upgrade
	end

  root :to =>  "home#index"
end