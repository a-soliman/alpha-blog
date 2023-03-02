class User < ApplicationRecord
  has_many :articles

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }

  EMAIL_REGEX = '/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/'
  validates :email, presence: true, uniqueness: { case_sensitive: false },  length: { maximum: 105 }, format: { with: EMAIL_REGEX }
end