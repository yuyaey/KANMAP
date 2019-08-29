class AddItemIconIdToItem < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM items;'
    add_reference :items, :item_icon, null: false, index: true
  end

  def down
    remove_reference :items, :item_icon, index: true
  end
end
