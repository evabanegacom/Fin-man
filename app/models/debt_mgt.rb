class DebtMgt < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  has_many :debt_payments, dependent: :destroy
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
end
