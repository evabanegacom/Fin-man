class Income < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  has_many :income_data, dependent: :destroy
end
