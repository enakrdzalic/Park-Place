class AddIndexToParks < ActiveRecord::Migration
  def change
    add_column :parks, :index, :int
  end
end
