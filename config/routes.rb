Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: "registrations"
  }
  
  resources :users
  resources :posts do
    collection do
      get :parse
    end
    resources :comments
  end
	
	root 'posts#index'
  get 'users(/:id)' => 'users#show'
  get 'recent' => 'posts#recent'
  get 'parse' => 'posts#parse'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
