class User < ApplicationRecord
    before_save {self.email = email.downcase }
    validates :name, presence: true, length: { minimum: 8, maximum: 16}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { minimum: 12, maximum: 24},
                      format: {with: VALID_EMAIL_REGEX}, 
                      uniqueness: { case_sensitive: false }    
    has_secure_password
    validates :password, presence: true, length: { minimum: 8, maximum: 16}

end
