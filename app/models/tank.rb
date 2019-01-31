class Tank < ActiveRecord::Base
  has_many :fish
  belongs_to :user
  validates :name, presence: true
end