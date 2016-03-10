class AddPrecisionAndScaleToCourseCost < ActiveRecord::Migration
  def up
    change_column :courses, :cost, :decimal, precision: 7, scale: 2
  end

  def down
    change_column :courses, :cost, :decimal
  end
end