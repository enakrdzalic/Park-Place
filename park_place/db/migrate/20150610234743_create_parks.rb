class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
        t.string "name"
        t.decimal "lat", :precision=>10, :scale=>6 ## UPDATED To new type
        t.decimal "lng", :precision=>10, :scale=>6 ## UPDATED To new type
        t.boolean "hasWashroom", :default => false
        t.timestamps
    end
  end
end
