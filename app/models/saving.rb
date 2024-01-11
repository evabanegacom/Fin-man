class Saving < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  has_many :saving_budgets, dependent: :destroy
end
