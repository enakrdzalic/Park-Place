class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
        t.int "parkID"
        t.int "index"
        t.string "name"
        t.float "lat"
        t.float "lng"
        t.boolean "hasWashroom", :default => false
        t.timestamps
    end
  end
end
