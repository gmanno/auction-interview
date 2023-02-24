class Bid < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :amount, presence: true, numericality: { only_float: true, greater_than: 0}
end
