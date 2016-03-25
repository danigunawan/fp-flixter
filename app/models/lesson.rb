class Lesson < ActiveRecord::Base
  belongs_to :section, inverse_of: :lessons

  mount_uploader :video, VideoUploader

  include RankedModel
  ranks :sort_order, with_same: :section_id
  
  validates :title, presence: true
  validates :subtitle, presence: true
  validates :video, presence: true

  def next_lesson
    next_lesson = section.lessons.where("sort_order > ?", sort_order).rank(:sort_order).first
    unless next_lesson 
      next_section = section.next_section_with_lessons
      next_lesson = next_section.lessons.rank(:sort_order).first if next_section
    end
    next_lesson
  end
end