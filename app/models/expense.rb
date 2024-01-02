class Expense < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader

end
