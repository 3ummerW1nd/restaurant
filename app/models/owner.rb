class Owner < ApplicationRecord
  has_many :restaurants
  validates :name,
            :presence => {:message => 'Name can\'t be null!'}
  validates :phone,
            :presence => {:message =>'Phone number can\'t be null!'},
            :uniqueness =>{:message => 'Your have registered. Login please'}
  validates :password,
            :presence => {:message => 'Password can\'t be null!'},
            :length => {:minimum => 8,
                        :maximum => 20,
                        :message => 'The length of password should between 8 and 20'}
  has_secure_password
end
