class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :comments
  has_many :replies
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

  def generate_authentication_token
    loop do
      token = SecureRandom.base64(64)
      if !$redis.get(token)
        $redis.set(token, self.id)
        $redis.expire(token, 2.hour.to_i)
        return token
      end
    end
  end

end
