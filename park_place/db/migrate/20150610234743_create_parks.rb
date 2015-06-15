class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
        t.string "name"
        t.float "lat" :precision=> 53 #, :scale=>10 ## UPDATED To new type
        t.float "lng" :precision=> 53  ## UPDATED To new type
        t.boolean "hasWashroom", :default => false
        t.timestamps
    end
  end
end
