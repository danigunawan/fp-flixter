class Lesson < ActiveRecord::Base
  belongs_to :section, inverse_of: :lessons

  mount_uploader :video, VideoUploader
  
  validates :title, presence: true
  validates :subtitle, presence: true
  validates :video, presence: true
end