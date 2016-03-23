class Lesson < ActiveRecord::Base
  belongs_to :section, inverse_of: :lessons

  mount_uploader :video, VideoUploader

  include RankedModel
  ranks :sort_order, with_same: :section_id
  
  validates :title, presence: true
  validates :subtitle, presence: true
  validates :video, presence: true
end