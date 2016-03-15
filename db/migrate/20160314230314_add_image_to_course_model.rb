class AddImageToCourseModel < ActiveRecord::Migration
  def change
    add_column :courses, :image, :string
  end
end