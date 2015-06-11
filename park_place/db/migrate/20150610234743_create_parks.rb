class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
        t.
        t.string "name"
        t.float "lat"
        t.float "long"
        t.boolean "hasWashroom", :default => false
        t.timestamps
    end
  end
end
