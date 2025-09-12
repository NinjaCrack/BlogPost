class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  #validations
  validates :user_id, uniqueness: { scope: :post_id } # Ensure a user can like a post only once
end
