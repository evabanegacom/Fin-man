module BudgetRecommendations
    def self.analyze_budgets(user)
        recommendations = []
      
        user.budgets.each do |budget|
          recommendation = "#{budget.name}: "
      
          # Calculate total budget actual spending
          total_budget_spent = BudgetExpense.where(budget_id: budget.id).sum(:amount)
      
          # Check if spending exceeds allocated budget
          if total_budget_spent > budget.target_amount
            overspending_amount = total_budget_spent - budget.target_amount
            recommendation += "For #{budget.name}, your spending has exceeded the allocated budget by $#{'%.2f' % overspending_amount}. "

        elsif total_budget_spent < budget.target_amount
            remaining_budget = budget.target_amount - total_budget_spent
            recommendation += "For #{budget.name}, you still have $#{'%.2f' % remaining_budget} left in your budget. "
          else
            recommendation += "For #{budget.name}, you have fully utilized your budget. "
        end
      
          # Analyze completion status of the budget
          if budget.completed
            recommendation += "For #{budget.name}, this budget has been completed. "
          else
            recommendation += "For #{budget.name}, this budget is still in progress. "
          end          
      
          # Additional budget planning recommendations
          recommendation += "Recommendations for budget planning: "
          recommendation += regular_reviews_recommendation(budget)
          recommendation += emergency_fund_allocation_recommendation(budget)
          recommendation += long_term_goals_recommendation(budget)
          recommendation += debt_repayment_recommendation(budget)
          recommendation += flexible_categories_recommendation(budget)
          recommendation += savings_prioritization_recommendation(budget)
          recommendation += contingency_planning_recommendation(budget)
          recommendation += track_discretionary_spending_recommendation(budget)
          recommendation += utilize_technology_recommendation(budget)
          recommendation += celebrate_milestones_recommendation(budget)
      
          recommendations << { category: "Budget", recommendation: recommendation }
        end
        return recommendations
      end
      
      # Additional budget planning recommendations
      def regular_reviews_recommendation(budget)
        if budget.target_date.present?
          return "Regularly review your budget for #{budget.name} to track spending patterns and make necessary adjustments, especially considering your target date of #{budget.target_date.strftime('%B %d, %Y')}."
        else
          return "Regularly review your budget for #{budget.name} to track spending patterns and make necessary adjustments."
        end
      end
      
      
      def emergency_fund_allocation_recommendation(budget)
        if budget.target_amount.present? && budget.target_date.present?
          return "For #{budget.name}, prioritize allocating funds towards building and maintaining an emergency fund to cover unexpected expenses. Aim to save at least #{'%.2f' % budget.target_amount} by #{budget.target_date.strftime('%B %Y')}. Consider automating regular contributions to your emergency fund to ensure consistent progress towards your goal."
        elsif budget.target_amount.present?
          return "For #{budget.name}, it's essential to allocate funds towards building and maintaining an emergency fund to cover unexpected expenses. Aim to save at least #{'%.2f' % budget.target_amount}. Consider setting up automatic transfers from your checking account to your emergency fund to ensure regular contributions."
        else
          return "For #{budget.name}, allocate a portion of your budget towards building and maintaining an emergency fund to cover unexpected expenses. Start by saving an amount equivalent to at least 3 to 6 months' worth of living expenses. Consider establishing a separate savings account specifically for your emergency fund."
        end
      end      
      
      def long_term_goals_recommendation(budget)
        if budget.target_amount.present? && budget.target_date.present?
          return "Incorporate long-term financial goals into your budget planning to prioritize saving for future objectives. Set specific targets and deadlines, such as saving #{'%.2f' % budget.target_amount} by #{budget.target_date.strftime('%B %Y')}, for major expenses like buying a house or funding retirement. Break down these goals into manageable milestones and adjust your budget to allocate funds accordingly."
        elsif budget.target_amount.present?
          return "Incorporate long-term financial goals into your budget planning to prioritize saving for future objectives. Set specific targets, such as saving #{'%.2f' % budget.target_amount}, for major expenses like buying a house or funding retirement. Break down these goals into manageable milestones and adjust your budget to allocate funds accordingly."
        else
          return "Incorporate long-term financial goals into your budget planning to prioritize saving for future objectives. Start by identifying your major financial aspirations, such as buying a house, starting a business, or retiring comfortably. Break down these goals into manageable milestones and adjust your budget to allocate funds accordingly."
        end
      end
      
      
      def debt_repayment_recommendation(user)
        # Find all budgets and debt management plans for the user
        user_budgets = Budget.where(user_id: user.id)
        user_debt_mgts = DebtMgt.where(user_id: user.id)
        
        total_budget_amount = user_budgets.sum(:target_amount)
        total_debt_amount = user_debt_mgts.sum(:target_amount)
        
        if total_debt_amount > 0 && total_budget_amount > 0
          debt_to_budget_ratio = total_debt_amount / total_budget_amount
        
          if debt_to_budget_ratio > 0.5
            return "Your total outstanding debt amount is $#{'%.2f' % total_debt_amount}, which is more than half of your total budget allocation of $#{'%.2f' % total_budget_amount}. It's important to prioritize debt repayment in your budget to reduce interest costs and achieve financial stability."
          else
            return "Your total outstanding debt amount is $#{'%.2f' % total_debt_amount}, which is less than half of your total budget allocation of $#{'%.2f' % total_budget_amount}. While debt repayment is important, ensure you're also allocating funds towards other essential expenses and financial goals in your budget."
          end
        elsif total_debt_amount > 0
          return "You have outstanding debt amounting to $#{'%.2f' % total_debt_amount}. It's crucial to prioritize debt repayment in your budget to reduce interest costs and achieve financial stability."
        else
          return "You currently have no outstanding debts. However, it's always advisable to allocate a portion of your budget towards debt repayment or building an emergency fund to prepare for unexpected expenses."
        end
      end       
      
      def flexible_categories_recommendation(budget)
        # Placeholder recommendation for flexible categories
        return "Consider including flexible spending categories in your budget to accommodate variable expenses and unforeseen circumstances. Some examples of flexible categories include:
        - Miscellaneous expenses: Allocate a portion of your budget for unexpected purchases or miscellaneous items.
        - Entertainment: Set aside funds for leisure activities, dining out, or entertainment expenses.
        - Travel: Plan for travel-related expenses, such as vacations or trips.
        - Home maintenance: Reserve funds for home repairs or maintenance tasks.
        - Health and wellness: Budget for healthcare expenses, gym memberships, or wellness activities.
        
        By incorporating flexible categories into your budget, you can better adapt to changes in your financial situation and maintain control over your spending."
      end
      
      
      def savings_prioritization_recommendation(budget)
        # Real recommendation for savings prioritization
        return "Prioritize savings goals in your budget to ensure consistent contributions towards financial security. Here are some actionable steps to effectively prioritize your savings:
      
        1. Build an emergency fund: Start by setting aside funds to cover unexpected expenses. Aim to save at least three to six months' worth of living expenses to provide a financial safety net in case of emergencies.
      
        2. Pay off high-interest debt: If you have outstanding debts with high interest rates, consider allocating extra funds towards debt repayment. Paying off high-interest debt can save you money on interest charges and free up more funds for savings in the long run.
      
        3. Save for short-term goals: Identify short-term financial goals such as a vacation, home repairs, or a new vehicle. Allocate funds towards these goals in your budget to ensure you can achieve them without resorting to debt.
      
        4. Invest in retirement accounts: Contribute to retirement accounts such as a 401(k) or IRA to build long-term wealth and secure your financial future. Take advantage of employer matching contributions if available to maximize your savings.
      
        5. Save for large purchases: If you have upcoming large expenses such as a down payment on a home or college tuition, prioritize saving for these goals in your budget. Plan ahead and set aside funds regularly to avoid financial strain when the time comes to make the purchase.
      
        6. Automate savings contributions: Make saving a habit by automating your contributions to savings accounts. Set up automatic transfers from your checking account to your savings account each month to ensure consistent savings without the need for manual intervention.
      
        By prioritizing savings goals and following these recommendations, you can build a strong financial foundation and work towards achieving your financial aspirations."
      end      
      
      def contingency_planning_recommendation(budget)
        # Real recommendation for contingency planning
        return "Allocate a portion of your budget towards contingency expenses to prepare for unexpected financial emergencies. Here are some essential steps to develop a robust contingency plan:
      
        1. Establish an emergency fund: Set aside funds in a separate savings account specifically designated for emergencies. Aim to save at least three to six months' worth of living expenses to cover unexpected costs such as medical emergencies, car repairs, or job loss.
      
        2. Review insurance coverage: Evaluate your insurance policies to ensure adequate coverage for potential risks. This includes health insurance, auto insurance, homeowners or renters insurance, and disability insurance. Make adjustments to your coverage as needed to protect yourself and your assets.
      
        3. Create a budget buffer: Incorporate a buffer into your monthly budget to accommodate unforeseen expenses or fluctuations in income. Allocate a portion of your budget for miscellaneous or discretionary spending to provide flexibility and cushion against unexpected costs.
      
        4. Identify alternative income sources: Explore opportunities to diversify your income streams and generate additional revenue. This could include freelancing, part-time work, rental income, or passive income investments. Having multiple income sources can help mitigate financial risks during challenging times.
      
        5. Plan for major life events: Anticipate major life events such as marriage, parenthood, or retirement and incorporate them into your contingency planning. Start saving and preparing for these milestones well in advance to minimize financial strain when they occur.
      
        6. Regularly review and update your plan: Continuously monitor and adjust your contingency plan as your financial situation evolves. Review your emergency fund balance, insurance coverage, and overall financial strategy periodically to ensure you're adequately prepared for any contingency.
      
        By implementing these contingency planning strategies, you can better protect yourself and your finances against unexpected events, giving you peace of mind and financial security."
      end
      
      
      def track_discretionary_spending_recommendation(budget)
        # Real recommendation for tracking discretionary spending
        return "Monitoring discretionary spending is crucial for maintaining a healthy financial balance. Here are some effective strategies to track and manage your discretionary expenses:
      
        1. Keep detailed records: Start by tracking all your discretionary expenses, such as dining out, entertainment, and shopping. Use a budgeting app, spreadsheet, or notebook to record each purchase and categorize it accordingly.
      
        2. Set spending limits: Establish monthly spending limits for different discretionary categories based on your overall budget and financial goals. Use these limits as guidelines to help control your spending and avoid overspending.
      
        3. Review your spending regularly: Take time each week or month to review your discretionary spending patterns. Look for trends, identify areas where you're overspending, and find opportunities to cut back.
      
        4. Identify areas for cost-cutting: Analyze your discretionary expenses to identify non-essential items or services that you can reduce or eliminate. Look for alternatives or cheaper alternatives to high-cost discretionary purchases.
      
        5. Prioritize your spending: Focus on spending money on experiences or items that align with your values and bring you genuine satisfaction. Prioritize discretionary purchases that contribute to your well-being and happiness.
      
        6. Be mindful of impulse purchases: Avoid making impulse purchases by practicing mindfulness and conscious spending. Pause and consider whether a purchase is necessary or if it aligns with your financial goals before making a decision.
      
        7. Celebrate small victories: Recognize and celebrate your progress in reducing discretionary spending. Set achievable goals and reward yourself when you successfully stick to your budget or achieve savings milestones.
      
        By tracking your discretionary spending and implementing these strategies, you can gain better control over your finances, reduce unnecessary expenses, and allocate more funds towards savings or debt repayment, ultimately improving your financial health and well-being."
      end 
end