class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    user = User.new(user_params)
    # user.activated = false
    if user.save
      user.update(activation_token: SecureRandom.urlsafe_base64)
      user.update(activation_token_expires_at: 2.days.from_now)
      # user.generate_activation_token
      puts "user token #{user.activation_token}"
      UserMailer.activation_email(user).deliver_now
      render json: { message: 'User created successfully. Please check your email for activation instructions.' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def activate
    puts "Activation token received: #{params[:token]}"
    user = User.find_by(activation_token: params[:token])

    # user = User.find_by(activation_token: params[:activation_token])
    puts "User found: #{user}"
    if user && !user.activated?
      puts "User found and not activated"
      user.update(activated: true)
      user.save(validate: false)
      user.skip_password_validation = true  # Skip password validation
      puts "User updated"
      # user.activation_token = nil
      render json: { message: 'Account activated successfully' }, status: :ok
    else
      render json: { error: 'Invalid activation token' }, status: :unprocessable_entity
    end
  end
  

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:name, :email, :password, :password_confirmation, :avatar)
    end
end

# {
#   "name": "louis debroglie",
#   "email": "precious@yahoo.com",
#   "password": "eaagleclaw",
#   "password_confirmattion": "eagleclaw"
# }
