class User < ApplicationRecord
    has_secure_password

    # profile picture
    has_one_attached :profile_picture

    # Associations
    has_many :posts, dependent: :destroy # If a user is deleted, their posts are also deleted
    has_many :comments, dependent: :destroy # If a user is deleted, their comments are also deleted
    # has_many :likes, dependent: :destroy # If a user is deleted, their likes are also deleted

    # Follows that I initiate
    has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy #  If a user is deleted, their follows are also deleted
    has_many :following, through: :active_follows, source: :followed # Users that I am following

    # Follows where I am the target
    has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy # If a user is deleted, their followers are also deleted
    has_many :followers, through: :passive_follows, source: :follower # Users that are following me



    # Validations
    validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 } # Username should be unique
    validates :name, presence: true # Name should be present
    VALID_EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/
    validates :email, presence: true,
     uniqueness: { case_sensitive: false }, # Email should be unique
     format: { with: VALID_EMAIL_REGEX }  # Email should be present and valid

    validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? } # Password validation only on create or when changed


    # helper methods
    def follow(other_user)
        following << other_user unless self == other_user
    end

    def unfollow(other_user)
        following.delete(other_user)
    end

    def following?(other_user)
        following.include?(other_user)
    end

  # def feed
  #     Post.where(user_id: following_ids + [id]).order(created_at: :desc)
  # end
end
