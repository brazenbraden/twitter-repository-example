Rails.application.routes.draw do
  devise_for :users
  resources :tweets, :comments, :replies
  root 'tweets#index'
end
