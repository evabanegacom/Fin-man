# app/controllers/api/v1/passwords_controller.rb
class Api::V1::PasswordsController < ApplicationController

  def reset
    user = User.find_by(email: params[:email])

    if user
      # Generate reset token and send password reset email
      user.reset_token = SecureRandom.urlsafe_base64
      user.reset_token_expires_at = 2.days.from_now
      user.save(validate: false)

      send_password_reset_email(user)

      render json: { message: 'Password reset email sent. Please check your email for instructions.' }, status: :ok
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  # ...

  private

  def send_password_reset_email(user)
    Mailjet.configure do |config|
      config.api_key = 'your_mailjet_api_key'
      config.secret_key = 'your_mailjet_secret_key'
      config.api_version = 'v3.1' # or your preferred Mailjet API version
    end

    # Replace with your Mailjet sender email and name
    sender_email = 'your_sender_email@example.com'
    sender_name = 'Your Sender Name'
    html_template_path = File.expand_path('../../../../views/user_mailer/password_reset_email.html.erb', __FILE__)

    # Use ERB to render dynamic content
    template = ERB.new(File.read(html_template_path))
    rendered_html = template.result(binding)

    # The rest of your code...

    variable_params = {
      'reset_link' => "https://your-app-domain.com/reset-password/#{user.reset_token}"
      # Add any other variables you want to include in your email template
    }

    message = Mailjet::Send.create(messages: [{
      'From' => {
        'Email' => sender_email,
        'Name' => sender_name
      },
      'To' => [{
        'Email' => user.email,
        'Name' => user.name
      }],
      'Subject' => 'Password Reset Instructions',
      'TextPart' => 'Follow the link to reset your password',
      'HTMLPart' => rendered_html,
      'Variables' => variable_params
    }])
    puts "Mailjet response: #{message.attributes.inspect}"
  end
end
