class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories

  self.per_page = 5
  before_save { self.name = name.downcase }

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 20 }
end