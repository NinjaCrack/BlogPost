class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  #comments association
  has_many :comments, dependent: :destroy # If a post is deleted, its comments are also deleted

  #likes association
  has_many :likes, dependent: :destroy # If a post is deleted, its likes are also deleted
  

  #validations
  validates :caption, presence: true, length: { maximum: 300 } # Caption should be present and not exceed 300 characters
  validates :image, presence: true # Image should be attached

end
