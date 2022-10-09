class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :replies
  validates :comment,
            :presence => {:message => 'Comment can\'t be null!'}
end
