class CreateMarkerManagers < ActiveRecord::Migration
  def change
    create_table :marker_managers do |t|

      t.timestamps null: false
    end
  end
end
