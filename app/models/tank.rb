class Tank < ActiveRecord::Base
  has_many :fish

  validates :name, presence: true
end