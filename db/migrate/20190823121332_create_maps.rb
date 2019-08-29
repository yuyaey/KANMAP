class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.bigint "kanzume_id"
      t.index ["kanzume_id"], name: "index_maps_on_kanzume_id"

      t.timestamps
    end
  end
end
