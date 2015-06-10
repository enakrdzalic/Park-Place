class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
      t.string :name
      t.float :lat
      t.float :lon
      t.boolean :hasWashroom

      t.timestamps null: false
    end
  end
end
