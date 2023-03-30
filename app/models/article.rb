class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
end
