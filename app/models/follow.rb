class Follow < ApplicationRecord
    belongs_to :follower, class_name: "User" # Self-referential association to the User model
    belongs_to :followed, class_name: "User" # Self-referential association to the User model

    #validation
    validates :follower_id, uniqueness: { scope: :followed_id } # Ensure a user can't follow the same user more than once
    validates :follower_id, presence: true # Ensure follower_id is present
    validates :followed_id, presence: true # Ensure followed_id is present
end
