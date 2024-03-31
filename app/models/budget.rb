class Budget < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  validates :name, presence: true, uniqueness: true
  has_many :budget_expenses, dependent: :destroy
  validates :target_amount, presence: true
  validates :target_date, presence: true
  valiidates :name, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
end
