class Dish < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :restaurant
  validates :name,
            :presence => {:message => 'Name can\'t be null!'}
end
