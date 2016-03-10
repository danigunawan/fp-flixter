class Course < ActiveRecord::Base
  belongs_to :user, inverse_of: :courses
  validates :title, presence: true
  validates :description, presence: :true
  validates :cost, presence: :true
end