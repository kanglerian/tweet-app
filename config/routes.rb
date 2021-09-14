Rails.application.routes.draw do
  get '/' => 'home#top'
  get '/about' => 'home#about'
  get 'post/index' => 'post#index'
  get 'post/new' => 'post#new'
  post 'post/create' => 'post#create'
  get 'post/:id' => 'post#show'
  get 'post/:id/edit' => 'post#edit'
  post 'post/:id/update' => 'post#update'
  post 'post/:id/destroy' => 'post#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
