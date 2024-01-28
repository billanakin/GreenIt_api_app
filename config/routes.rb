Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :signups, only: %i[create]
  resources :sessions, only: %i[create] do
    get    :show, on: :collection
    delete :destroy, on: :collection
  end

  resources :posts do
    get :trending, on: :collection
    get :near_me, on: :collection
    get :latest, on: :collection
    get :recommended, on: :collection
    get :friends, on: :collection
  end
end
