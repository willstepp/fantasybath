Fantasybath::Application.routes.draw do
	scope '/workshop' do
    match '/' => 'workshop#index', :via => :get, :as => :workshop
		resources :scents
  	resources :products
	end

  root :to =>  "home#index"
end
