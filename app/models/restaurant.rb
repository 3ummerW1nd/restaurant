class Restaurant < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :name,
            :presence => {:message => 'Name can\'t be null!'}
end