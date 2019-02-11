class User < ActiveRecord::Base
  has_many :tank
  has_secure_password
  validates :username, presence: true, uniqueness: true
  
end
