class AddOrderingToLessonModel < ActiveRecord::Migration
  def change
    add_column :lessons, :sort_order, :integer
    add_index :lessons, :sort_order
  end
end