class Enrollment < ActiveRecord::Base
  belongs_to :user, inverse_of: :enrollments
  belongs_to :course, inverse_of: :enrollments
end