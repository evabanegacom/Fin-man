Rails.application.routes.draw do
  root 'static#index'
  namespace :api do
    namespace :v1 do

      resources :incomes do
        collection do
          post 'create_income_data'
        end
      end

      resources :debt_mgts do
        collection do
          get 'search_by_name_or_date_created'
        end
        #http://localhost:3000/api/v1/debt_mgts/search_by_name_or_date_created?user_id=39&name=testing

        collection do
          delete 'delete_debtmgt'
        end

        collection do
          get 'index'
        end

        member do 
          post 'create_debt_payment'
        end

        collection do
          delete 'delete_debt_payment'
        end

        collection do
          get 'debt_payments'
        end

        member do
          get 'upcoming_debt_payment'
        end
      end
      
      resources :financial_plans
      resources :budgets do
        collection do
          get 'search'
        end
        
        collection do
          post 'budget_expenses' #http://localhost:3001/api/v1/budgets/budget_expenses
        end

        member do
          get 'upcoming_budget_expense' #http://localhost:3001/api/v1/budgets/1/upcoming_budget_expense
        end

        collection do
          get 'budget_usage' #http://localhost:3001/api/v1/budgets/budget_usage
        end

        collection do
          delete 'delete_budget'
        end

      end
      resources :savings do 
        collection do
          get 'search'
        end
        member do
          post 'add_savings_budget'
        end
        member do
          get 'upcoming_savings_budget'
        end
      end
      resources :expenses
      get 'unread_notifications', to: 'notifications#unread_notifications'
      # post 'create_other_finance_activity_notification', to: 'notifications#create_other_finance_activity_notification'
      post 'create_notification', to: 'notifications#create'
      post 'generate_activation_token', to: 'users#generate_activation_token'
      # User registration and activation routes
      get '/user/budgets/:user_id', to: 'budgets#userBudgets'

      resources :users, only: %i[create index destroy]
      
      post '/activate', to: 'users#activate'
      
      post '/sign_in', to: 'users#sign_in'

      get 'monthly_savings', to: 'aggregates#savings'

      get 'recommendations', to: 'recommendations#generate_recommendations'

      # Password reset routes
      post '/password/reset', to: 'passwords#reset', as: 'reset_password'
      get '/password/reset/:reset_token', to: 'passwords#edit', as: 'edit_password'
      put '/password/update', to: 'passwords#update', as: 'update_password'

      # Other API routes...
    end
  end

  # Other non-API routes...
end
