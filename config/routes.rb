Rails.application.routes.draw do
  root 'static#index'
  namespace :api do
    namespace :v1 do
      resources :incomes
      resources :debt_mgt do
        collection do
          get 'search'
        end
      end
      resources :financial_plans
      resources :budgets
      resources :savings
      resources :expenses

      # User registration and activation routes
      get '/user/budgets/:user_id', to: 'budgets#userBudgets'
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

      # Other API routes...
    end
  end

  # Other non-API routes...
end
