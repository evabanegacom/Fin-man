class RecommendationsController < ApplicationController
    def generate_recommendations
        user = User.find(params[:user_id])
  
      # Analyze user's budget data
      budget_recommendation = analyze_budget(user)
  
      # Prioritize user's debts
      debt_recommendation = prioritize_debts(user)
  
      # Optimize user's savings strategy
      savings_recommendation = optimize_savings(user)
  
      # Review and adjust financial plans
      financial_plan_recommendation = review_financial_plans(user)
  
      # Analyze user's expenses
      expense_recommendation = analyze_expenses(user)
  
      # Maximize user's income potential
      income_recommendation = maximize_income(user)
  
      # Compile all recommendations
      recommendations = [budget_recommendation, debt_recommendation, savings_recommendation, financial_plan_recommendation, expense_recommendation, income_recommendation]
  
      render json: recommendations
    end
  
    private
  
    def analyze_user_finances(user)
        recommendations = []
      
        # Analyze Budgets
        user.budgets.each do |budget|
          total_expenses = budget.budget_expenses.sum(:amount)
      
          # Check if total expenses exceed the allocated amount
          if total_expenses > budget.target_amount
            recommendations << {
              category: 'Budget',
              recommendation: "Your spending for budget '#{budget.name}' exceeds the allocated amount. Consider adjusting your spending."
            }
          end
      
          # Check if any budget is incomplete
          unless budget.completed
            recommendations << {
              category: 'Budget',
              recommendation: "You have an incomplete budget '#{budget.name}'. Please complete it to effectively manage your finances."
            }
          end
      
          # Check if any budget is approaching its target date
          if budget.target_date.present? && budget.target_date < Date.today + 7.days
            recommendations << {
              category: 'Budget',
              recommendation: "Your budget '#{budget.name}' is approaching its target date. Review and adjust if necessary to meet your financial goals."
            }
          end
      
          # Check if contribution type and amount are specified
          if budget.contribution_type.present? && budget.contribution_amount.blank?
            recommendations << {
              category: 'Budget',
              recommendation: "You have specified a contribution type for budget '#{budget.name}' but haven't set the contribution amount. Please specify the contribution amount to track your progress accurately."
            }
          end
      
          # Check if category is missing
          if budget.category.blank?
            recommendations << {
              category: 'Budget',
              recommendation: "You haven't specified a category for budget '#{budget.name}'. Assigning a category will help you organize and manage your budgets more effectively."
            }
          end
        end
      
        # Analyze Savings
        # Analyze Savings
user.savings.each do |saving|
    # Check if savings target date is approaching
    if saving.target_date.present? && saving.target_date < Date.today + 7.days
      recommendations << {
        category: 'Savings',
        recommendation: "The target date for your savings '#{saving.name}' is approaching. Ensure you are on track to meet your savings goal."
      }
    end
  
    # Check if contribution amount is missing
    if saving.contribution_amount.blank?
      recommendations << {
        category: 'Savings',
        recommendation: "You haven't specified a contribution amount for savings '#{saving.name}'. Determine how much you plan to save regularly to achieve your goal."
      }
    end
  
    # Check if purpose is missing
    if saving.purpose.blank?
      recommendations << {
        category: 'Savings',
        recommendation: "The purpose for your savings '#{saving.name}' is not specified. Clarify your savings goal to stay focused and motivated."
      }
    end
  
    # Check if savings amount is less than the target amount
    if saving.contribution_amount.present? && saving.target_amount.present? && saving.contribution_amount < saving.target_amount
      recommendations << {
        category: 'Savings',
        recommendation: "Your savings contribution for '#{saving.name}' is less than the target amount. Consider increasing your contributions to reach your savings goal faster."
      }
    end
  
    # Check if savings avatar is missing
    if saving.avatar.blank?
      recommendations << {
        category: 'Savings',
        recommendation: "You haven't added an avatar for savings '#{saving.name}'. Adding an avatar can help personalize your savings goals and keep you motivated."
      }
    end
  end
  
      
        # Analyze Debt Management
        user.debt_mgts.each do |debt_mgmt|
          # Add recommendations for debt management analysis
          # For example, check if debt repayment target date is approaching, or if contribution amount is missing
        end
      
        # Analyze Expenses
        user.expenses.each do |expense|
          # Add recommendations for expenses analysis
          # For example, check if expenses exceed income, or if expense category is missing
        end
      
        # Analyze Financial Plans
        user.financial_plans.each do |financial_plan|
          # Add recommendations for financial plans analysis
          # For example, check if financial plan target date is approaching, or if target amount is missing
        end
      
        recommendations
      end      
  
      def prioritize_debts(user)
        recommendations = []
      
        user.debt_mgts.each do |debt_mgmt|
          # Check if debt repayment target date is approaching
          if debt_mgmt.target_date.present? && debt_mgmt.target_date < Date.today + 7.days
            recommendations << {
              category: 'Debt Management',
              recommendation: "The target date for repaying your debt '#{debt_mgmt.name}' is approaching. Make sure you have a plan in place to meet your repayment goal."
            }
          end
      
          # Check if contribution amount is missing
          if debt_mgmt.contribution_amount.blank?
            recommendations << {
              category: 'Debt Management',
              recommendation: "You haven't specified a contribution amount for debt '#{debt_mgmt.name}'. Determine how much you can allocate towards debt repayment regularly."
            }
          end
      
          # Check if debt completion status is false
          unless debt_mgmt.completed
            recommendations << {
              category: 'Debt Management',
              recommendation: "The debt '#{debt_mgmt.name}' is still pending. Make sure to keep track of it and plan your payments accordingly."
            }
          end
      
          # Check if interest rates are not favorable
          if debt_mgmt.interest_rate.to_f > 0.1
            recommendations << {
              category: 'Debt Management',
              recommendation: "The interest rate for your debt '#{debt_mgmt.name}' is relatively high. Consider prioritizing repayment of this debt to minimize interest costs."
            }
          end
      
          # Check if debt amount is significantly large
          if debt_mgmt.target_amount.to_f > 10000
            recommendations << {
              category: 'Debt Management',
              recommendation: "The amount owed for debt '#{debt_mgmt.name}' is quite substantial. Focus on paying off this debt as soon as possible to reduce financial strain."
            }
          end
      
          # Check if debt avatar is missing
          if debt_mgmt.avatar.blank?
            recommendations << {
              category: 'Debt Management',
              recommendation: "You haven't added an avatar for debt '#{debt_mgmt.name}'. Adding an avatar can help visualize your debt and motivate you to pay it off."
            }
          end
      
          # Ensure a maximum of six recommendations
          break if recommendations.length >= 6
        end
      
        recommendations
      end
      
  
    def optimize_savings(user)
      # Implement logic to optimize user's savings strategy
      # Example: Check if user is contributing enough to savings to meet financial goals
      # Adjust recommendation message based on analysis
      {
        category: 'Savings',
        recommendation: 'Increase your contributions to savings to meet your financial goals faster.'
        # Add more recommendation details as needed
      }
    end
  
    def review_financial_plans(user)
      # Implement logic to review and adjust user's financial plans
      # Example: Check if user's financial plans are aligned with current financial situation
      # Adjust recommendation message based on analysis
      {
        category: 'Financial Plans',
        recommendation: 'Review your financial plans and make adjustments to adapt to changing circumstances.'
        # Add more recommendation details as needed
      }
    end
  
    def analyze_expenses(user)
      # Implement logic to analyze user's expenses
      # Example: Check if there are areas where user can reduce spending
      # Adjust recommendation message based on analysis
      {
        category: 'Expenses',
        recommendation: 'Identify areas where you can reduce spending to save more money.'
        # Add more recommendation details as needed
      }
    end
  
    def maximize_income(user)
      # Implement logic to maximize user's income potential
      # Example: Check if user can explore additional income streams
      # Adjust recommendation message based on analysis
      {
        category: 'Income',
        recommendation: 'Explore opportunities to increase your income through additional income streams or career advancement.'
        # Add more recommendation details as needed
      }
    end
  end
  