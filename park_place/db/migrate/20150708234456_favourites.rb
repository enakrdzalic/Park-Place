class Favourites < ActiveRecord::Migration
    def change
        create_table :favourites do |t|
            t.belongs_to :user, index: true
            t.belongs_to :park, index: true
            t.timestamps null: false
        end
    end
end
