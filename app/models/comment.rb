class Comment < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :comment,
            :presence => {:message => 'Comment can\'t be null!'}
end
