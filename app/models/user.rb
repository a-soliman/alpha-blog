class User < ApplicationRecord
  has_many :articles

  validates :username, presence: true, uniqueness: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true
end