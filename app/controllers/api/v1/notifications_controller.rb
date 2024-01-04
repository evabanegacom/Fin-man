class Api::V1::NotificationsController < ApplicationController
    before_action :set_notification, only: [:show, :update, :destroy]
  
    def create
      item_type = params[:item_type]
      user_id = params[:user_id]
      case item_type
      when 'BudgetExpense'
        create_budget_expense_notification(user_id)
      when 'OtherFinanceActivity'
        create_other_finance_activity_notification
      else
        render json: { error: 'Unsupported item type' }, status: :unprocessable_entity
      end
    end

    def create_budget_expense_notification(user_id)
        budgets = Budget.where(user_id: user_id)
        
        budgets.each do |budget|
          last_budget_expense_date = BudgetExpense.where(budget_id: budget.id)
                                                  .order(created_at: :desc)
                                                  .pluck(:created_at)
                                                  .first
        
          if last_budget_expense_date.present?
            upcoming_contribution_date =
              case budget.contribution_type
              when 'Weekly'
                last_budget_expense_date + 1.week
              when 'Daily'
                last_budget_expense_date + 1.day
              when 'Monthly'
                last_budget_expense_date + 1.month
              else
                last_budget_expense_date
              end
        
            if upcoming_contribution_date < Date.today
              title = "Upcoming Budget Expense: #{budget.name}"
              description = "You have an upcoming budget expense '#{budget.name}' on #{upcoming_contribution_date}. The target amount is #{budget.target_amount}."
        
              @notification = Notification.new(title: title, description: description, user_id: 11, item_type: 'BudgetExpense')
        
              if @notification.save
                render json: @notification, status: :created
                return
              else
                render json: @notification.errors, status: :unprocessable_entity
                return
              end
            else
              render json: { message: 'No notification needed for this scenario' }
              return
            end
          else
            render json: { message: 'No notification needed for this scenario' }
            return
          end
        end
      end
  
    def create_other_finance_activity_notification
      user_id = params[:user_id]
      other_finance_activity_id = params[:other_finance_activity_id]
      other_finance_activity = OtherFinanceActivity.find(other_finance_activity_id)
  
      notification = Notification.create(
        title: 'Other Finance Activity',
        description: "You have a new other finance activity: #{other_finance_activity.name}",
        item_type: 'OtherFinanceActivity',
        user_id: user_id
      )
  
      render json: notification
    end
  
    def unread_notifications
      user_id = params[:user_id]
      notifications = Notification.where(user_id: user_id, read: false)
  
      render json: notifications
    end
  
    def mark_notifications_as_read
      user_id = params[:user_id]
      notifications = Notification.where(user_id: user_id, read: false)
  
      notifications.update_all(read: true)
  
      render json: { message: 'Notifications marked as read successfully' }
    end
  
    private
  
    def set_notification
      @notification = Notification.find(params[:id])
    end
  
    def notification_params
      params.permit(:title, :description, :user_id, :read, :item_type)
    end
  end
  