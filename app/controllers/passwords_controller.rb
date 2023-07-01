# app/controllers/passwords_controller.rb
class PasswordsController < ApplicationController
    # ...

    def reset
      user = User.find_by(email: params[:email])
    
      if user
        # Generate reset token and send password reset email
        user.reset_token = SecureRandom.urlsafe_base64
        user.reset_token_expires_at = 2.days.from_now
        user.save(validate: false)
    
        UserMailer.password_reset_email(user).deliver_now
    
        render json: { message: 'Password reset email sent. Please check your email for instructions.' }, status: :ok
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    end
    
      def edit
        puts "Reset token received: #{params[:reset_token]}"
        @user = User.find_by(reset_token: params[:reset_token])
        puts "User found: #{@user}"
        if @user && @user.reset_token_valid?
          render json: { message: 'Reset password' }, status: :ok
        elsif @user && !@user.reset_token_valid?
          render json: { error: 'Reset token has expired' }, status: :unprocessable_entity
        else
          render json: { error: 'Invalid reset token' }, status: :unprocessable_entity
        end
      end
  
    def update
      user = User.find_by(reset_token: params[:reset_token])
  
      if user && user.reset_token_valid?
        user.update(password: params[:password], password_confirmation: params[:password_confirmation], reset_token: nil)
        render json: { message: 'Password reset successful' }, status: :ok
      elsif user && !user.reset_token_valid?
        render json: { error: 'Reset token has expired' }, status: :unprocessable_entity
      else
        render json: { error: 'Invalid reset token' }, status: :unprocessable_entity
      end
    end
  end
  