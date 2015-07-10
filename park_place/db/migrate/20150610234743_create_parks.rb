class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
        t.integer "parkID"
        t.integer "index"
        t.string "name"
        t.float "lat"
        t.float "lng"
        t.string "neighbourhood"
        t.boolean "hasWashroom", :default => false
        t.boolean "isLarge", :default => false
        t.timestamps
    end
  end
end
