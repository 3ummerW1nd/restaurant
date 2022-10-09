class Reply < ApplicationRecord
  validates :reply,
            :presence => {:message => 'Reply can\'t be null!'}
end
