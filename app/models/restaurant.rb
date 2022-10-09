class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :dishes
  validates :name,
            :presence => {:message => 'Name can\'t be null!'}
end
