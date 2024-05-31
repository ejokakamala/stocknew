Rails.application.routes.draw do
  get '/users', to: 'users#index'
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'public#dashboard', as: :authenticated_root
      get '/edit', to: 'devise/registrations#edit', as: :edit_user
      put '/update', to: 'devise/registrations#update', as: :update_user
      get '/import', to: 'public#import'
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
   
  
  resources :flocks do
    collection { post :import }
  end
  resources :incomes do
    collection { post :import }
  end
  resources :fixed_expenses do
    collection { post :import }
  end
  resources :expenses do
    collection { post :import }
    #collection { post :bulk_add_data }
  end
  resources :batches do 
    collection { post :import }
  end
 
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

end
