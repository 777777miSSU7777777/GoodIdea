class Post < ApplicationRecord
    belongs_to :user
    has_many :donations, dependent: :delete_all
    validates :title, presence: true, length: { maximum: 30}
    validates :content, presence: true, length: { maximum: 15000}
    validates_numericality_of :goal, presence: true, greater_than_or_equal_to: 1

end
