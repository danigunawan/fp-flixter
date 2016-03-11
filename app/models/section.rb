class Section < ActiveRecord::Base
  belongs_to :course, inverse_of: :sections
  validates :title, presence: true
end