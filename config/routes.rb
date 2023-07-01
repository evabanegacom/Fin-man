Rails.application.routes.draw do
  # User registration and activation routes
  resources :users, only: [:create]
  get '/activate/:token', to: 'users#activate', as: 'activate_account'
  post '/activate/:token', to: 'users#activate'

  # User login and logout routes
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Password reset routes
  post '/password/reset', to: 'passwords#reset', as: 'password_reset'
  get '/password/reset/:reset_token', to: 'passwords#edit', as: 'edit_password'
  put '/password/reset', to: 'passwords#update', as: 'update_password'

  # Other routes...
end
