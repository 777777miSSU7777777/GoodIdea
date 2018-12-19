class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :msg, presence: true, length: { maximum: 150}
  validates_numericality_of :amount, presence: true, greater_than_or_equal_to: 1
end
