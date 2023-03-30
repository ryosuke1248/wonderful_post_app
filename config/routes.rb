Rails.application.routes.draw do
  devise_for :users
  # get 'home/index'
  root to: 'articles#index'

  get '/mypage', to: 'mypage#show'
  resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
