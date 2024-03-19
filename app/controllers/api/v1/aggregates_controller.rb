class Api::V1::AggregatesController < ApplicationController
  
    def savings
        user = User.find(params[:user_id])
        
        # Initialize variables outside of the loops
        monthly_saving_budget = 0
        yearly_saving_budget = 0
      
        monthly_savings = Saving.where(user_id: user.id).where("created_at >= ?", Date.today.beginning_of_month)
        yearly_savings = Saving.where(user_id: user.id).where("created_at >= ?", Date.today.beginning_of_year)
        
        # Accumulate values within the loops
        monthly_savings.each do |saving|
          monthly_saving_budget += SavingBudget.where(saving_id: saving.id).sum(:amount)
        end
        
        yearly_savings.each do |saving|
          yearly_saving_budget += SavingBudget.where(saving_id: saving.id).sum(:amount)
        end
        
        # Render the JSON response outside of the loops
        render json: { monthly_savings: monthly_savings.count, yearly_savings: yearly_savings.count, monthly_saving_budget: monthly_saving_budget, yearly_saving_budget: yearly_saving_budget }
      end
      
end