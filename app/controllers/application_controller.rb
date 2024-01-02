class ApplicationController < ActionController::API
    include CurrentUser
    #before_action :authenticate_request
  
    private
  
    def authenticate_request
      render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user
    end
  end
  