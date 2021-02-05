Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/signup', to: 'registrations#signup'

  post '/login', to: 'sessions#login'
  delete '/logout', to: 'sessions#logout'
  get '/logged_in', to: 'sessions#logged_in?'
  get '/test', to: 'sessions#test'
  post '/test', to: 'sessions#test'

  resources :contests, only: %i[index show] do
    resources :chances, only: :index
  end
  resources :bets, only: %i[index destroy] do
    get :publish, on: :member
  end
  resources :chances, only: [] do
    resources :bets, only: %i[create]
  end

  resource :user, only: %i[show]
end
