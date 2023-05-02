Rails.application.routes.draw do
  devise_for :users
  
  get '/splash', to: 'public#splash'
end
