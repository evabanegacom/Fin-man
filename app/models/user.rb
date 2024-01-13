# app/models/user.rb
class User < ApplicationRecord
  # before_create :generate_activation_token, :generate_reset_token
  # Validations
  mount_uploader :avatar, AvatarUploader
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 }
  
  # Associations
  has_secure_password

  has_many :budgets, dependent: :destroy
  has_many :debt_mgts, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :financial_plans, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :savings, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def generate_reset_token!
    self.reset_token = SecureRandom.urlsafe_base64
    self.reset_token_expires_at = 1.day.from_now
  end

  def activation_token_valid?
    activation_token_expires_at.present? && activation_token_expires_at > Time.now
  end

  def reset_token_valid?
    reset_token_expires_at.present? && reset_token_expires_at > Time.now
  end

  def as_json(options = {})
    super(options.merge({ except: %i[password_digest created_at updated_at] }))
  end
  
end
  