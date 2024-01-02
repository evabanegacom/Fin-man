class Budget < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  validates :name, presence: true, uniqueness: true
  has_many :budget_expenses, dependent: :destroy
end
