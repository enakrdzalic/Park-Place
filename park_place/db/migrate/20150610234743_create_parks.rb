class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
        t.integer "parkID"
        t.integer "index"
        t.string "name"
        t.float "lat"
        t.float "lng"
        t.string "neighbourhood"
        t.string "hasWashroom",
        t.string "isLarge",
        t.timestamps
    end
  end
end
