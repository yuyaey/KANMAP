class AddKanzumeIconIdToKanzume < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM kanzumes;'
    add_reference :kanzumes, :kanzume_icon, null: false, index: true
  end

  def down
    remove_reference :kanzumes, :kanzume_icon, index: true
  end
end
