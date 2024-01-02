# app/services/current_user.rb
module CurrentUser
    def current_user
      @current_user ||= User.find_by(id: user_id_from_token)
    end
  
    private
  
    def user_id_from_token
      token = request.headers['Authorization']&.split&.last
      decoded_token = decode_token(token) if token
      decoded_token['user_id'] if decoded_token
    end
  
    def decode_token(token)
      begin
        JWT.decode(token, Rails.application.secrets.secret_key_base).first
      rescue JWT::ExpiredSignature, JWT::DecodeError
        nil
      end
    end
  end
  