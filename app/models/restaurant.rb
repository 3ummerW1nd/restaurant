class Restaurant < ApplicationRecord
  belongs_to :owner
  has_many :comments
  has_many :dishes
end
