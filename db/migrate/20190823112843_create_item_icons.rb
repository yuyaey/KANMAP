class CreateItemIcons < ActiveRecord::Migration[5.2]
  def change
    create_table :item_icons do |t|
      t.string :name
      t.string :picture

      t.timestamps
    end
  end
end
