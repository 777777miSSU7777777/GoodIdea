class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :delete_all
    validates :title, presence: true, length: { minimum: 5, maximum: 30}
    validates :content, presence: true, length: { minimum: 500, maximum: 15000}
end
