Rails.application.routes.draw do
  root 'static#index'
  namespace :api do
    namespace :v1 do
      resources :incomes
      resources :debt_mgts do
        collection do
          get 'search'
        end

        collection do
          get 'index'
        end

        member do 
          post 'create_debt_payments'
        end
         
      end
      resources :financial_plans
      resources :budgets do
        collection do
          get 'search'
        end
        collection do
          post 'budget_expenses'
        end
        member do
          get 'upcoming_budget_expense' #http://localhost:3001/api/v1/budgets/1/upcoming_budget_expense
        end
      end
      resources :savings
      resources :expenses
      get 'unread_notifications', to: 'notifications#unread_notifications'
      # post 'create_other_finance_activity_notification', to: 'notifications#create_other_finance_activity_notification'
      post 'create_notification', to: 'notifications#create'

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
