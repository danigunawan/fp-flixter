class Lesson < ActiveRecord::Base
  belongs_to :section, inverse_of: :lessons
  
  validates :title, presence: true
  validates :subtitle, presence: true
end