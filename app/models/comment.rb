class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # validations
  validates :body, presence: true, length: { minimum: 1 } # Content should be present and at least 1 character long
end
