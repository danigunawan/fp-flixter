class AddSortOrderToSectionModel < ActiveRecord::Migration
  def change
    add_column :sections, :sort_order, :integer
    add_index :sections, :sort_order
  end
end