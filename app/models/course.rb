class Course < ActiveRecord::Base
  belongs_to :user, inverse_of: :courses
  has_many :sections, inverse_of: :course, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: :true
  validates :cost, presence: :true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 99999.99}
end