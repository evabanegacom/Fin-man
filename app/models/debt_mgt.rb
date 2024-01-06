class DebtMgt < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  has_many :debt_payments, dependent: :destroy
end
