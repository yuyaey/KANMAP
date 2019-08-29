class AddKanzumeIdToItems < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM items;'
    add_reference :items, :kanzume, null: false, index: true
  end

  def down
    remove_reference :items, :kanzume, index: true
  end
end

