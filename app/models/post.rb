class Post < ApplicationRecord
    belongs_to :user
    has_many :donations, dependent: :delete_all
    validates :title, presence: true, length: { minimum: 5, maximum: 30}
    validates :content, presence: true, length: { minimum: 500, maximum: 15000}
    validates_numericality_of :goal, presence: true, greater_than_or_equal_to: 1

end
