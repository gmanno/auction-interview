class Bid < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :amount, presence: true, numericality: { only_float: true, greater_than: 0 }

  scope :higher, -> { order(amount: :desc).limit(1).take }
  scope :current_by_user, ->(user_id) { order(amount: :desc).find_by(user_id: user_id) }
end
