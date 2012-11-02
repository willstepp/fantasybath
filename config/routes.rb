Fantasybath::Application.routes.draw do
	scope '/workshop' do
    match '/' => 'workshop#index', :via => :get, :as => :workshop

		resources :scents
  	resources :products

    match '/products/:id/images' => 'products#images', :via => :get, :as => :product_images
    match '/products/:id/upload_image' => 'products#upload_image', :via => :post, :as => :upload_image
    match '/products/:id/delete_image' => 'products#delete_image', :via => :delete, :as => :delete_image

    match '/products/:id/upgrades' => 'products#upgrades', :via => :get, :as => :product_upgrades
    match '/products/:id/update_upgrade' => 'products#update_upgrade', :via => :post, :as => :update_upgrade
    match '/products/:id/delete_upgrade' => 'products#delete_upgrade', :via => :delete, :as => :delete_upgrade
	end

  root :to =>  "home#index"
end