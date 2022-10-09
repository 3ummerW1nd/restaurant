class Dish < ApplicationRecord
  belongs_to :restaurant
  validates :name,
            :presence => {:message => 'Name can\'t be null!'}
end
