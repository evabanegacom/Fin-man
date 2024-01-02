class Api::V1::SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])
  
      if user&.authenticate(params[:password])
        token = generate_token(user.id)
        render json: { message: 'Logged in successfully', token: token }
      else
        render json: { message: 'Invalid email or password' }, status: :unauthorized
      end
    end
  
    private
  
    def generate_token(user_id)
      payload = { user_id: user_id, exp: 24.hours.from_now.to_i } # Set the expiry to 24 hours from now
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end
  end
  