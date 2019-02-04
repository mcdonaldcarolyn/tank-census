class Tank < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates_uniqueness_of :name
end