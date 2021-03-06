Rails.application.routes.draw do
  get 'searchs/search'
  get 'search/search'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get '/home/about' => 'homes#about'
  get '/search' => 'searchs#search'

  resources :users do
  resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :books do

    resource :favorites, only: [:create, :destroy]

    resources :book_comments,  only: [:create, :destroy]
  end

end
