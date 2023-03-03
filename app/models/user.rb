class User < ApplicationRecord
  self.per_page = 10
  before_save { self.email = email.downcase }
  
  has_many :articles

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false },  length: { maximum: 105 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :bio, length: { maximum: 500 }
  
  has_secure_password
end