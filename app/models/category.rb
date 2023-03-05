class Category < ApplicationRecord
  self.per_page = 5
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 20 }
end