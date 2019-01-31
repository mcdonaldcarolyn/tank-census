class User < ActiveRecord::Base
  has_many :tank
  has_secure_password
end
