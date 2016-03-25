class Section < ActiveRecord::Base
  belongs_to :course, inverse_of: :sections
  has_many :lessons, inverse_of: :section, dependent: :destroy
  
  include RankedModel
  ranks :sort_order, with_same: :course_id 

  validates :title, presence: true

  def next_section_with_lessons
    next_section = self
    while (next_section)
      next_section = course.sections.where("sort_order > ?", next_section.sort_order).rank(:sort_order).first
      return next_section if next_section && next_section.lessons.present?
    end
    next_section
  end
end