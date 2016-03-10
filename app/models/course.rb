class Course < ActiveRecord::Base
  belongs_to :user, inverse_of: :courses
  validates :title, presence: true
  validates :description, presence: :true
  validates :cost, presence: :true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 99999.99}
end